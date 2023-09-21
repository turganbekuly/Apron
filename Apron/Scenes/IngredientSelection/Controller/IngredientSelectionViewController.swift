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

final class IngredientSelectionViewController: ViewController {
    // MARK: - Properties

    let interactor: IngredientSelectionBusinessLogic
    var state: State {
        didSet {
            updateState()
        }
    }

    weak var delegate: IngredientSelectedProtocol?

    var measurementType: [String] = MeasureTypes.allCases.map { $0.rawValue }

    var recipeIgredient = RecipeIngredient()

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

    var initialState: IngredientSelectionInitialState?

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
        button.backgroundType = .blackBackground
        button.setTitle(L10n.Common.Save.title, for: .normal)
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
        self.tabBarController?.tabBar.isHidden = true
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
        backButton.configure(with: L10n.IngredientSelection.Ingredient.add)
        backButton.onBackButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.backgroundColor = APRAssets.secondary.color
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
        saveButton.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(100)
        }
    }

    private func configureViews() {
        view.addSubview(recipeTextField)

        if initialState == .fullItem {
            view.addSubview(measureTextField)
            measureTextField.measurementTyptextField.inputView = picker
            picker.delegate = self
            picker.dataSource = self
        }

        configureColors()
        makeConstraints()
    }

    private func makeConstraints() {
        recipeTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(38)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        if initialState == .fullItem {
            measureTextField.snp.makeConstraints {
                $0.top.equalTo(recipeTextField.snp.bottom).offset(16)
                $0.height.equalTo(38)
                $0.leading.trailing.equalToSuperview().inset(16)
            }
        }
    }

    private func setupDropdown() {
        DropDown.appearance().cellHeight = 40
        dropDown.anchorView = recipeTextField
        dropDown.cellNib = UINib(nibName: "ProductDropDownCell", bundle: nil)
        dropDown.bottomOffset = CGPoint(x: 0, y: (dropDown.anchorView?.plainView.bounds.height)!)
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
        view.backgroundColor = APRAssets.secondary.color
    }

    func configureSaveButtonEnabled(isEnabled: Bool) {
        saveButton.isEnabled = isEnabled
    }

    deinit {
        NSLog("deinit \(self)")
    }

    // MARK: - Private methods

    private func converter(text: String) -> String {
        let conversion = Double(text.replacingOccurrences(of: ",", with: ".")) ?? 0.0
        return String(format: "%.2f", conversion)
    }

    // MARK: - User actions

    @objc
    private func saveButtonTapped() {
        guard let _ = recipeIgredient.product?.id else {
            show(type: .error(L10n.IngredientSelection.Ingredient.chooseFromList))
            return
        }

        if initialState == .fullItem {
            guard let _ = measureTextField.measurementTyptextField.text else {
                show(type: .error(L10n.IngredientSelection.Ingredient.chooseMeasureTF))
                return
            }

            recipeIgredient.amount = Double(converter(text: measureTextField.amountTextField.text ?? "0.0"))
            recipeIgredient.measurement = measureTextField.measurementTyptextField.text
        }

        delegate?.onIngredientSelected(ingredient: recipeIgredient)
        navigationController?.popViewController(animated: true)
    }

    @objc
    private func didEnterRecipe(_ sender: UITextField) {
        dropDown.hide()
        getProducts(query: sender.text ?? "")
    }
}
