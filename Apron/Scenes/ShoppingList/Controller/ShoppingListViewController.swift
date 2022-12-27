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

protocol ShoppingListDisplayLogic: AnyObject {
    func displayCartItems(viewModel: ShoppingListDataFlow.GetCartItems.ViewModel)
    func displayClearCartItems(viewModel: ShoppingListDataFlow.ClearCartItems.ViewModel)
}

final class ShoppingListViewController: ViewController, Messagable {
    
    struct Section {
        enum Section {
        case ingredients
        case checkedIngredients
        }
        enum Row {
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
            var sections = [Section]()
            if (cartItems.firstIndex(where: { $0.bought == false }) != nil) {
                sections.append(
                    .init(
                        section: .ingredients, rows: cartItems
                            .filter { $0.bought == false }
                            .compactMap { .ingredient($0) }
                    )
                )
            }

            if (cartItems.firstIndex(where: { $0.bought == true }) != nil) {
                sections.append(
                    .init(
                        section: .checkedIngredients, rows: cartItems
                            .filter { $0.bought == true }
                            .compactMap { .ingredient($0) }
                    )
                )
            }
            self.sections = sections
            UIView.transition(
                with: mainView,
                duration: 0.5,
                options: .transitionCrossDissolve,
                animations: {self.mainView.reloadTableViewWithoutAnimation()},
                completion: nil
            )
        }
    }
    
    // MARK: - Views

    lazy var mainView: ShoppingListView = {
        let view = ShoppingListView()
        view.dataSource = self
        view.delegate = self
        return view
    }()

    private lazy var moreButton = NavigationIconFillButton()

    private lazy var backButton = NavigationBackButton()

    private lazy var avatarView = AvatarView()

    private lazy var orderButton: BlackOpButton = {
        let button = BlackOpButton()
        button.backgroundType = .greenBackground
        button.setTitle("Заказать", for: .normal)
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        return button
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
        OneSignal.sendTag("shopping_list_page_viewed", value: "\(initialState)")
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
        backButton.configure(with: "Список покупок")
        backButton.onBackButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        avatarView.onTap = { [weak self] in
            guard let self = self else { return }
            self.handleAuthorizationStatus {
                let viewController = ProfileBuilder(state: .initial).build()
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
        }
        moreButton.icon = ApronAssets.navMoreButton.image.withTintColor(.black)
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
        navigationController?.navigationBar.backgroundColor = ApronAssets.secondary.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreButton)
    }
    
    private func configureViews() {
        [mainView, orderButton].forEach { view.addSubview($0) }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        orderButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }

        mainView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(orderButton.snp.top).offset(-16)
        }
    }
    
    private func configureColors() {
        view.backgroundColor = ApronAssets.secondary.color
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
        let link = RemoteConfigManager.shared.remoteConfig.orderFromStoreLink
        guard !link.isEmpty else { return }
        let webViewController = WebViewHandler(urlString: link)
        ApronAnalytics.shared.sendAnalyticsEvent(.shoppingListCheckoutTapped(cartItems.map { $0.productName }))
        OneSignal.sendTag("shopping_list_checkout_tapped", value: "order_button_tapped")
        present(webViewController, animated: true)
    }

    // MARK: - Private functions

    func shareIngredients(cartItems: [CartItem]) {
        let viewController = UIActivityViewController(
            activityItems: cartItems.map { "\($0.productName) - \($0.amount?.clean ?? "") \($0.measurement ?? "")"},
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
        OneSignal.sendTag("ingredients_added", value: "shopping_list")
        var productAmount: Double = 0
        if cartManager.isContains(product: ingredient.product?.name ?? "") {
            productAmount = CartManager.shared.getProductAmount(for: ingredient.product?.name ?? "")
        }
        cartManager.update(
            productId: ingredient.product?.id ?? 0,
            productName: ingredient.product?.name ?? "",
            productCategoryName: ingredient.product?.productCategoryName ?? "",
            productImage: ingredient.product?.image,
            amount: (ingredient.amount ?? 0) + productAmount,
            measurement: ingredient.measurement ?? "",
            recipeName: "Личный продукт",
            bought: false
        )
        fetchCartItems()
    }
}
