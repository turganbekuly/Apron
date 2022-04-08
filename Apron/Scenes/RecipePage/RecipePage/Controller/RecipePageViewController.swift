//
//  RecipePageViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit
import Models

protocol RecipePageDisplayLogic: AnyObject {
    
}

final class RecipePageViewController: ViewController {
    // MARK: - Properties

    let interactor: RecipePageBusinessLogic

    var sections: [Section] = []

    var selectedIndexPath = IndexPath(row: .zero, section: .zero)
    var pages: [RecipeInitialState] = [.ingredients, .instruction, .calories]

    var state: State {
        didSet {
            updateState()
        }
    }

    var topView = [
        InformationCellViewModel(
            recipeName: "Легкий грибной суп",
            recipeSubtitle: "в Вегетарианские рецепты и еще 2 сообществах",
            recipeSourceURL: "asdgamer1995123"
        )
    ]

    var descriptions = [
        IngredientsDescriptionCellViewModel(
            description: "Очень простой суп из шампиньонов, картофеля, лука и макарон. Бюджетный, быстрый и лёгкий.",
            cookingTime: "30 мин"
        )
    ]


    var ingredients = [
        IngredientsListCellViewModel(
            serveCount: 6,
            ingredients: [
                IngredientInfo(
                    ingredientImage: "",
                    ingredientName: "Шампиньоны",
                    ingredientMeasurement: "г",
                    ingredientAmount: "300"
                ),
                IngredientInfo(
                    ingredientImage: "",
                    ingredientName: "Макароны",
                    ingredientMeasurement: "г",
                    ingredientAmount: "100"
                ),
                IngredientInfo(
                    ingredientImage: "",
                    ingredientName: "Картофель",
                    ingredientMeasurement: "шт",
                    ingredientAmount: "4"
                ),
                IngredientInfo(
                    ingredientImage: "",
                    ingredientName: "Лук репчатый",
                    ingredientMeasurement: "г",
                    ingredientAmount: "1"
                ),
                IngredientInfo(
                    ingredientImage: "",
                    ingredientName: "Зелень",
                    ingredientMeasurement: "пучка",
                    ingredientAmount: "0.5"
                ),
                IngredientInfo(
                    ingredientImage: "",
                    ingredientName: "Соль",
                    ingredientMeasurement: "по вкусу",
                    ingredientAmount: "0"
                ),
                IngredientInfo(
                    ingredientImage: "",
                    ingredientName: "Лавровый лист",
                    ingredientMeasurement: "шт",
                    ingredientAmount: "1-2"
                ),
                IngredientInfo(
                    ingredientImage: "",
                    ingredientName: "Масло растительное",
                    ingredientMeasurement: "мл",
                    ingredientAmount: "30-40"
                ),
                IngredientInfo(
                    ingredientImage: "",
                    ingredientName: "Вода",
                    ingredientMeasurement: "л",
                    ingredientAmount: "2.5"
                )
            ]
        )
    ]

    var steps = [
        InstructionCellViewModel(
            instructions: [
                InstructionInformations(
                    stepCount: "1",
                    stepDescription: "Нагреть сковороду с растительным маслом. Обжарить лук, помешивая, на среднем огне до румяности"
                ),
                InstructionInformations(
                    stepCount: "1",
                    stepDescription: "Подготовить продукты."
                ),InstructionInformations(
                    stepCount: "1",
                    stepDescription: "Подготовить продукты."
                ),
                InstructionInformations(
                    stepCount: "1",
                    stepDescription: "Подготовить продукты."
                ),
                InstructionInformations(
                    stepCount: "1",
                    stepDescription: "Подготовить продукты."
                ),
                InstructionInformations(
                    stepCount: "1",
                    stepDescription: "Подготовить продукты."
                ),
                InstructionInformations(
                    stepCount: "1",
                    stepDescription: "Подготовить продукты."
                )
            ]
        )
    ]
    
    // MARK: - Views factory

    lazy var mainView: RecipePageView = {
        let view = RecipePageView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(interactor: RecipePageBusinessLogic, state: State) {
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: Assets.navBackButton.image,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.backgroundColor = Assets.secondary.color
    }
    
    private func configureViews() {
        [mainView].forEach { view.addSubview($0) }
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
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
}
