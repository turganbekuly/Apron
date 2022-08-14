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

    private lazy var addProductButton: BlackOpButton = {
        let button = BlackOpButton(backgroundType: .yelloBackground)
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.setImage(ApronAssets.creationPlusButton.image, for: .normal)
        button.clipsToBounds = true
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

        ApronAnalytics.shared.sendAmplitudeEvent(.shoppingListViewed)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigation()
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
        moreButton.icon = ApronAssets.navMoreButton.image.withTintColor(.black)
        moreButton.onTouch = { [weak self] in
            self?.navigateToCreateActionFlow(with: .shoppingListMore)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.backgroundColor = ApronAssets.secondary.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: moreButton)
    }
    
    private func configureViews() {
        [mainView, addProductButton].forEach { view.addSubview($0) }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        addProductButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(50)
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
    private func saveButtonTapped() {
        //
    }

    @objc
    private func createButtonTapped() {
        let vc = IngredientSelectionBuilder(state: .initial(self)).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: false)
        }
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
