//
//  ShoppingListViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Storages
import AlertMessages
import Models
import RemoteConfig
import OneSignal
import SnapKit

protocol ShoppingListDisplayLogic: AnyObject {
    func displayCartItems(viewModel: ShoppingListDataFlow.GetCartItems.ViewModel)
    func displayClearCartItems(viewModel: ShoppingListDataFlow.ClearCartItems.ViewModel)
}

final class ShoppingListViewController: ViewController {
    
    struct Section {
        enum Section {
            case ingredients
        }
        enum Row: Equatable {
            case ingredient(CartItem)
            case empty
        }
        
        let section: Section
        let rows: [Row]
    }
    
    // MARK: - Properties
    let interactor: ShoppingListBusinessLogic
    var sections: [Section] = []
    var state: State {
        didSet {
            updateState()
        }
    }
    
    var initialState: ShoppingListEntryPoint?
    
    var cartManager = CartManager.shared
    
    var cartItems: [CartItem] = [] {
        didSet {
            guard !cartItems.isEmpty else {
                sections = [.init(section: .ingredients, rows: [.empty])]
                mainView.reloadTableViewWithoutAnimation()
                return
            }
            
            sections = [
                .init(section: .ingredients, rows: cartItems.compactMap { .ingredient($0) })
            ]
            
            mainView.reloadData()
        }
    }
    
    var orderBannerViewHeightConstarints: Constraint?
    // MARK: - Views
    
    lazy var mainView: ShoppingListView = {
        let view = ShoppingListView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    lazy var canOrderBannerView = CanOrderBannerView()
    
    private lazy var moreButton = NavigationIconFillButton()
    
    private lazy var backButton = NavigationBackButton()
    
    private lazy var avatarView = AvatarView()
    
    private lazy var orderButton: BlackOpButton = {
        let button = BlackOpButton()
        button.backgroundType = .blackBackground
//        button.setTitle(L10n.ShoppingList.Order.title, for: .normal)
        button.setTitle(L10n.CreateActionFlow.ShareIngredients.title, for: .normal)
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 23
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var addProductButton: BlackOpButton = {
        let button = BlackOpButton()
        button.backgroundType = .whiteBackground
        button.setTitle(L10n.ShoppingList.AddProduct.title, for: .normal)
        button.addTarget(self, action: #selector(addProductButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 23
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addProductButton, orderButton])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Init
    init(interactor: ShoppingListBusinessLogic, state: State) {
        self.interactor = interactor
        self.state = state
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        configureViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        state = { state }()
        
        ApronAnalytics.shared.sendAnalyticsEvent(.shoppingListViewed)
        
        cartManager.subscribe(self) {
            //
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigation()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }
    
    // MARK: - Methods
    private func configureNavigation() {
        backButton.configure(with: L10n.ShoppingList.ListOfProducts.title)
        backButton.onBackButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
        avatarView.onTap = { [weak self] in
            guard let self = self else { return }
            self.handleAuthorizationStatus {
                let viewController = ProfileBuilder(state: .initial).build()
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(viewController, animated: false)
                }
            }
        }
        moreButton.icon = APRAssets.navMoreButton.image.withTintColor(.black)
        moreButton.onTouch = { [weak self] in
            self?.navigateToCreateActionFlow(with: .shoppingListMore)
        }
        switch initialState {
        case .tab:
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: avatarView)
        case .regular:
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        default:
            break
        }
        navigationController?.navigationBar.backgroundColor = APRAssets.secondary.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreButton)
    }
    
    private func configureViews() {
        [mainView, hStackView, /*canOrderBannerView*/].forEach { view.addSubview($0) }
//        canOrderBannerView.delegate = self
        canOrderBannerView.configure(
            title: "Закажите продукты онлайн!",
            description: "Теперь вы можете заказать продукты через нас буквально за 1 клик!",
            buttonTitle: "Посмотреть как?"
        )
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
//        canOrderBannerView.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            $0.leading.trailing.equalToSuperview()
//            orderBannerViewHeightConstarints = $0.height.equalTo(200).constraint
//        }
        
        hStackView.snp.makeConstraints {
            $0.height.equalTo(46)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        mainView.snp.makeConstraints {
//            $0.top.equalTo(canOrderBannerView.snp.bottom).offset(8)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(orderButton.snp.top).offset(-16)
        }
    }
    
    private func configureColors() {
        view.backgroundColor = APRAssets.secondary.color
    }
    
    private func navigateToCreateActionFlow(with state: CreateActionInitialState) {
        let vc = CreateActionFlowBuilder.init(state: .initial(state, self)).build()
        DispatchQueue.main.async {
            self.navigationController?.presentPanModal(vc)
        }
    }

    deinit {
        NSLog("deinit \(self)")
    }
    
    // MARK: - User actions
    
    @objc
    private func orderButtonTapped() {
        //        let link = RemoteConfigManager.shared.remoteConfig.orderFromStoreLink
        //        guard !link.isEmpty else { return }
        //        let webViewController = WebViewHandler(urlString: link)
        fetchCartItems()
        let items = cartManager.fetchItems()
        guard !items.isEmpty else {
            show(type: .error(L10n.ShoppingList.AddProductsToBuyList.title))
            return
        }
//        orderProducts(cartItems: items.filter { $0.bought })
        shareIngredients(cartItems: items.filter { $0.bought })
        ApronAnalytics.shared.sendAnalyticsEvent(.shoppingListCheckoutTapped(items.map { $0.productName }))
        OneSignal.sendTag("shopping_list_checkout_tapped", value: "order_button_tapped")
        OneSignal.addTrigger("shopping_list_checkout_tapped", withValue: "order_button_tapped")
    }
    
    @objc
    private func addProductButtonTapped() {
        let vc = IngredientSelectionBuilder(state: .initial(self, .fullItem)).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - Private functions
    
    func orderProducts(cartItems: [CartItem]) {
        let items = L10n.ShoppingList.Order.link
        var ingredientsText = "Добрый день! Хочу заказать вот эти продукты ...\n"
        for item in cartItems {
            ingredientsText.append("\(item.productName) - \(item.amount?.clean ?? "") \(item.measurement ?? "")")
            ingredientsText.append("\n")
        }
        
        if let url = URL(string: items + (ingredientsText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func shareIngredients(cartItems: [CartItem]) {
        var items = ""
        for item in cartItems {
            items.append("\(item.productName) - \(item.amount?.clean ?? "") \(item.measurement ?? "")")
            items.append("\n")
        }
        let viewController = UIActivityViewController(
            activityItems: [items],
            applicationActivities: nil
        )
        
        if let popoover = viewController.popoverPresentationController {
            popoover.sourceView = view
            popoover.sourceRect = view.bounds
            popoover.permittedArrowDirections = []
        }
        
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }
}

extension ShoppingListViewController: IngredientSelectedProtocol {
    func onIngredientSelected(ingredient: RecipeIngredient) {
        ApronAnalytics.shared.sendAnalyticsEvent(
            .ingredientAdded(
                IngredientAddedModel(
                    id: ingredient.product?.id ?? 0,
                    name: ingredient.product?.name ?? "",
                    sourceType: .selectionFromShoppingList
                )
            )
        )
        var productAmount: Double = 1
        if cartManager.isContains(product: ingredient.product?.name ?? "") {
            productAmount = CartManager.shared.getProductAmount(for: ingredient.product?.name ?? "")
        }
        cartManager.update(
            productId: ingredient.product?.id ?? 0,
            productName: ingredient.product?.name ?? "",
            productCategoryName: ingredient.product?.productCategoryName ?? "",
            productImage: ingredient.product?.image,
            amount: ingredient.amount ?? productAmount,
            measurement: ingredient.measurement ?? "",
            recipeName: L10n.ShoppingList.SelfProduct.title,
            bought: false
        )
        
        let cartItems = cartManager.fetchItems()
        sections = [
            .init(section: .ingredients, rows: cartItems.compactMap { .ingredient($0) })
        ]
        mainView.reloadData()
    }
}
