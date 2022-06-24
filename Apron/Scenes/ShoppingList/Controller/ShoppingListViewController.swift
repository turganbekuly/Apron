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
}

final class ShoppingListViewController: ViewController, Messagable {
    
    struct Section {
        enum Section {
        case ingredients
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

    var itemsDictionary = [String: [CartItem]]()

    var cartItems: [CartItem]? {
        didSet {
            guard let cartItems = cartItems,
                  !cartItems.isEmpty
            else {
                sections = [.init(section: .ingredients, rows: [.empty])]
                mainView.reloadTableViewWithoutAnimation()
                return
            }

            sections = [
                .init(section: .ingredients, rows: cartItems.compactMap { .ingredient($0) })
            ]
            mainView.reloadTableViewWithoutAnimation()
        }
    }
    
    // MARK: - Views
    lazy var mainView: ShoppingListView = {
        let view = ShoppingListView()
        view.dataSource = self
        view.delegate = self
        return view
    }()

    private lazy var navigationRightButton: NavigationButton = {
        let button = NavigationButton()
        button.backgroundType = .whiteBackground
        button.setTitle("Поделиться", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

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
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.backgroundColor = ApronAssets.secondary.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navigationRightButton)
        navigationRightButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
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
}

extension ShoppingListViewController: IngredientSelectedProtocol {
    func onIngredientSelected(ingredient: RecipeIngredient) {
        CartManager.shared.update(
            productName: ingredient.product?.name ?? "",
            productCategoryName: ingredient.product?.productCategoryName ?? "",
            amount: ingredient.amount ?? 0,
            quantity: 1,
            measurement: ingredient.measurement ?? "",
            recipeName: "Личный продукт"
        )
        fetchCartItems()
    }
}
