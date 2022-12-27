//
//  PreShoppingListViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Storages
import AlertMessages

final class PreShoppingListViewController: ViewController, Messagable {
    
    struct Section {
        enum Section {
            case ingredients
        }
        enum Row {
            case ingredient(CartItem)
        }
        
        let section: Section
        let rows: [Row]
    }
    
    // MARK: - Properties

    var sections: [Section] = []
    var state: State {
        didSet {
            updateState()
        }
    }

    weak var delegate: PreShoppingListDismissedDelegate?

    let cartManager = CartManager.shared
    var cartItems: [CartItem] = [] {
        didSet {
            selectedItems = cartItems
            sections = [.init(section: .ingredients, rows: cartItems.compactMap { .ingredient($0) })]
            mainView.reloadData()
        }
    }

    var selectedItems: [CartItem] = []
    
    // MARK: - Views

    private lazy var backButton = NavigationBackButton()

    private lazy var addButton: NavigationButton = {
        let button = NavigationButton()
        button.backgroundType = .greenBackground
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var mainView: PreShoppingListView = {
        let view = PreShoppingListView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(state: State) {
        self.state = state
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    deinit {
        NSLog("deinit \(self)")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        configureViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        state = { state }()
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
        backButton.configure(with: "Предпросмотр")
        backButton.onBackButtonTapped = { [weak self] in
            self?.delegate?.dismissed()
            self?.navigationController?.popViewController(animated: true)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.backgroundColor = ApronAssets.secondary.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        addButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(30)
        }
    }
    
    private func configureViews() {
        [mainView].forEach { view.addSubview($0) }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configureColors() {
        view.backgroundColor = ApronAssets.secondary.color
    }

    // MARK: - User actions

    @objc
    private func addButtonTapped() {
        if selectedItems.isEmpty {
            show(type: .error("Пожалуйста, выберите не менее 1 продукта"))
            return
        }

        selectedItems.forEach {
            cartManager.update(
                productId: $0.productId,
                productName: $0.productName,
                productCategoryName: $0.productCategoryName,
                productImage: $0.productImage,
                amount: $0.amount,
                measurement: $0.measurement,
                recipeName: $0.recipeName?.first ?? "",
                bought: false
            )
        }

        selectedItems.forEach {
            ApronAnalytics.shared.sendAnalyticsEvent(
                .ingredientAdded(
                    IngredientAddedModel(
                        id: $0.productId,
                        name: $0.productName,
                        sourceType: .recipePage
                    )
                )
            )
        }

        delegate?.dismissedWithIngredients()
        self.navigationController?.popViewController(animated: true)
    }
}
