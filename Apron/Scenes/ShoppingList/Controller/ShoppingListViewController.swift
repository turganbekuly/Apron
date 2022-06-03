//
//  ShoppingListViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
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

    private lazy var shareButton: BlackOpButton = {
        let button = BlackOpButton(
            backgroundType: .whiteBackground, arrowState: .none,
            frame: CGRect(x: 0, y: 0, width: 90, height: 30)
        )
        button.setTitle("Поделиться", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Список покупок"
        label.font = TypographyFonts.semibold20
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(
            Assets.navBackButton.image
                .withTintColor(.black),
            for: .normal
        )
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var leftButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()

    private lazy var addProductButton: BlackOpButton = {
        let button = BlackOpButton(backgroundType: .yelloBackground)
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.setImage(Assets.creationPlusButton.image, for: .normal)
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButtonStackView)
        navigationController?.navigationBar.backgroundColor = Assets.secondary.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
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
        view.backgroundColor = Assets.secondary.color
    }
    
    deinit {
        NSLog("deinit \(self)")
    }

    // MARK: - User actions

    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

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
