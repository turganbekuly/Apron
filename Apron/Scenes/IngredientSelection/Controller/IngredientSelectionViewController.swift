//
//  IngredientSelectionViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models
import DropDown
import AlertMessages

protocol IngredientSelectionDisplayLogic: AnyObject {
    func displayProducts(viewModel: IngredientSelectionDataFlow.GetProducts.ViewModel)
}

final class IngredientSelectionViewController: ViewController, Messagable {
    // MARK: - Properties

    let interactor: IngredientSelectionBusinessLogic
    var state: State {
        didSet {
            updateState()
        }
    }

    var delegate: IngredientSelectedProtocol?

    var measurementType: [String] = MeasureTypes.allCases.map { $0.rawValue }

    var recipeIgredient = RecipeIngredient()

    var products: [Product]? {
        didSet {
            if let products = products, !products.isEmpty {
                dropDown.dataSource = products.compactMap { $0.name }
                dropDown.show()
            }
        }
    }
    
    // MARK: - Views

    lazy var recipeTextField: RoundedTextField = {
        let textField = RoundedTextField(placeholder: "Поиск ингредиента")
        textField.textField.addTarget(self, action: #selector(didEnterRecipe(_:)), for: .editingChanged)
        return textField
    }()

    private lazy var dropDown = DropDown()

    lazy var measureTextField: MeasureInputView = {
        let inputView = MeasureInputView(
            amountPlaceholder: "Введите кол-во",
            measurePlaceholder: "Выберите тип"
        )
        inputView.delegate = self
        return inputView
    }()

    private let picker: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .white
        return picker
    }()

    private lazy var saveButton: NavigationButton = {
        let button = NavigationButton()
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var backButton = NavigationBackButton()

    
    // MARK: - Init

    init(interactor: IngredientSelectionBusinessLogic, state: State) {
        self.interactor = interactor
        self.state = state
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        state = { state }()
        configureViews()
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
        backButton.configure(with: "Добавить ингредиент")
        backButton.onBackButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.backgroundColor = ApronAssets.secondary.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        saveButton.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(100)
        }
    }
    
    private func configureViews() {
        [recipeTextField, measureTextField].forEach { view.addSubview($0) }

        measureTextField.measurementTyptextField.inputView = picker
        picker.delegate = self
        picker.dataSource = self

        configureColors()
        makeConstraints()
        setupDropdown()
    }
    
    private func makeConstraints() {
        recipeTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(38)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        measureTextField.snp.makeConstraints {
            $0.top.equalTo(recipeTextField.snp.bottom).offset(16)
            $0.height.equalTo(38)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    private func setupDropdown() {
        dropDown.anchorView = measureTextField
        dropDown.direction = .bottom
        dropDown.selectionAction = { [weak self] (index, product) in
            guard let self = self,
                  let products = self.products
            else { return }
            self.recipeIgredient.product = products[index]
            self.recipeTextField.textField.text = product
        }
    }
    
    private func configureColors() {
        view.backgroundColor = ApronAssets.secondary.color
    }

    func configureSaveButtonEnabled(isEnabled: Bool) {
        saveButton.isEnabled = isEnabled
    }
    
    
    deinit {
        NSLog("deinit \(self)")
    }

    // MARK: - User actions

    @objc
    private func saveButtonTapped() {
        guard let _ = recipeIgredient.product?.id else {
            show(type: .error("Пожалуйста, выберите ингредиент из списка"))
            return
        }
        recipeIgredient.amount = Double(measureTextField.amountTextField.text ?? "0")
        recipeIgredient.measurement = measureTextField.measurementTyptextField.text
        delegate?.onIngredientSelected(ingredient: recipeIgredient)
        navigationController?.popViewController(animated: true)
    }

    @objc
    private func didEnterRecipe(_ sender: UITextField) {
        dropDown.hide()
        getProducts(query: sender.text ?? "")
    }
}
