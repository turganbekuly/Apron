//
//  IngredientSelectionViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit
import Models

protocol IngredientSelectionDisplayLogic: AnyObject {
    func displayProducts(viewModel: IngredientSelectionDataFlow.GetProducts.ViewModel)
}

final class IngredientSelectionViewController: ViewController {
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
    
    // MARK: - Views

    lazy var recipeTextField: RoundedTextField = {
        let textField = RoundedTextField(placeholder: "Поиск ингредиента")
        return textField
    }()

    let measureTextField: MeasureInputView = {
        let inputView = MeasureInputView(
            amountPlaceholder: "Введите кол-во",
            measurePlaceholder: "Выберите тип"
        )
        return inputView
    }()

    private let picker: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .white
        return picker
    }()

    private lazy var saveButton: BlackOpButton = {
        let button = BlackOpButton(arrowState: .none, frame: CGRect(x: 0, y: 0, width: 90, height: 30))
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавить рецепт"
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButtonStackView)
        navigationController?.navigationBar.backgroundColor = Assets.secondary.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
    }
    
    private func configureViews() {
        [recipeTextField, measureTextField].forEach { view.addSubview($0) }

        measureTextField.measurementTyptextField.inputView = picker
        picker.delegate = self
        picker.dataSource = self

        configureColors()
        makeConstraints()
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
    
    private func configureColors() {
        view.backgroundColor = Assets.secondary.color
    }

    private func configureSaveButtonEnabled(isEnabled: Bool) {
        saveButton.isEnabled = isEnabled
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
        let product = Product()
        recipeIgredient.id = 1
        recipeIgredient.product = product
        recipeIgredient.product?.name = recipeTextField.textField.text
        recipeIgredient.product?.id = 7
        recipeIgredient.amount = Double(measureTextField.amountTextField.text ?? "0")
        recipeIgredient.measurement = MeasureTypes(rawValue: measureTextField.measurementTyptextField.text ?? "")
        delegate?.onIngredientSelected(ingredient: recipeIgredient)
        navigationController?.popViewController(animated: true)
    }
}
