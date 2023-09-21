//
//  SearchByIngredientsViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models
import DropDown
import HapticTouch
import AlertMessages
import Extensions

protocol SearchByIngredientsDisplayLogic: AnyObject {
    func displayProductsByIds(viewModel: SearchByIngredientsDataFlow.GetProductsByIDs.ViewModel)
    func displayProductsByName(viewModel: SearchByIngredientsDataFlow.GetProductsByName.ViewModel)
}

final class SearchByIngredientsViewController: ViewController {
    
    struct Section {
        enum Section {
            case selectedIngredients
            case suggestedIngredients
        }
        enum Row: Equatable {
            case suggestedIngredient(Product)
            case selectedIngredient(Product)
        }
        
        let section: Section
        var rows: [Row]
    }
    
    // MARK: - Properties
    let interactor: SearchByIngredientsBusinessLogic
    var sections: [Section] = [] {
        didSet {
            mainView.reloadData()
        }
    }
    var state: State {
        didSet {
            updateState()
        }
    }
    
    var throttler = Throttler(minimumDelay: 0.3)
    
    var suggestedProducts: [Product] = [] {
        didSet {
            configureSections()
        }
    }
    var selectedProducts: [Product] = [] {
        didSet {
            configureSections()
            applyButton.setTitle("Поиск с \(selectedProducts.count) ингредиентами", for: .normal)
            applyButton.isEnabled = selectedProducts.count > 0 ? true : false
        }
    }
    
    var products: [Product]? {
        didSet {
            if let products = products, !products.isEmpty {
                dropDown.dataSource = products.compactMap { $0.name }
                dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
                    guard let cell = cell as? ProductDropDownCell else { return }
                    cell.optionLabel.text = products[index].name
                    cell.productImageView.kf.setImage(
                        with: URL(string: products[index].image ?? ""),
                        placeholder: APRAssets.iconPlaceholderItem.image
                    )
                }
                dropDown.show()
            }
        }
    }
    
    // MARK: - Views
    
    private lazy var backButton = NavigationBackButton()
    
    lazy var recipeTextField: RoundedTextField = {
        let textField = RoundedTextField(placeholder: "Поиск ингредиента")
        textField.textField.addTarget(self, action: #selector(didEnterRecipe(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var mainView: SearchByIngredientsView = {
        let view = SearchByIngredientsView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var dropDown = DropDown()
    
    private lazy var applyButton: BlackOpButton = {
        let button = BlackOpButton()
        button.backgroundType = .blackBackground
        button.setTitle("Поиск с 0 ингредиентами", for: .normal)
        button.addTarget(self, action: #selector(applyButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Init
    init(interactor: SearchByIngredientsBusinessLogic, state: State) {
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupDropdown()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }
    
    // MARK: - Methods
    private func configureNavigation() {
        backButton.configure(with: "Поиск по ингредиентам")
        backButton.onBackButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.backgroundColor = APRAssets.secondary.color
    }
    
    private func configureViews() {
        [recipeTextField, mainView, applyButton].forEach { view.addSubview($0) }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        applyButton.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        recipeTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(34)
        }
        
        mainView.snp.makeConstraints {
            $0.top.equalTo(recipeTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(applyButton.snp.top).offset(-16)
        }
    }
    
    private func setupDropdown() {
        DropDown.appearance().cellHeight = 40
        dropDown.anchorView = recipeTextField
        dropDown.cellNib = UINib(nibName: "ProductDropDownCell", bundle: nil)
        dropDown.bottomOffset = CGPoint(x: 0, y: (dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.dismissMode = .onTap
        dropDown.selectionAction = { [weak self] (index, product) in
            guard let self = self,
                  let products = self.products
            else { return }
            
            guard !selectedProducts.contains(where: { $0.name == product }) else {
                show(type: .error(L10n.SearchByIngredients.Product.alreadyAdded))
                HapticTouch.generateError()
                return
            }
            self.selectedProducts.append(products[index])
            self.recipeTextField.textField.text = ""
        }
    }
    
    private func configureColors() {
        view.backgroundColor = APRAssets.secondary.color
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
    // MARK: - User actions
    
    @objc
    private func didEnterRecipe(_ sender: UITextField) {
        throttler.throttle {
            self.dropDown.hide()
            self.getProductsByName(name: sender.text ?? "")
        }
    }
    
    @objc
    private func applyButtonTapped() {
        ApronAnalytics.shared.sendAnalyticsEvent(.searchByIngredientsResult(products: selectedProducts))
        let vc = SearchByIngredientsResultBuilder(state: .initial(productIds: selectedProducts.compactMap { "\($0.id ?? 0)" })).build()
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    // MARK: - Methods
    
    func configureSections() {
        var sections = [Section]()
        if !selectedProducts.isEmpty {
            sections.append(
                .init(section: .selectedIngredients, rows: selectedProducts.compactMap { .selectedIngredient($0) })
            )
        }
        
        if !suggestedProducts.isEmpty {
            sections.append(
                .init(section: .suggestedIngredients, rows: suggestedProducts.compactMap { .suggestedIngredient($0) })
            )
        }
        
        self.sections = sections
    }
}
