//
//  IngredientsPageViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit
import Models

protocol IngredientsPageDisplayLogic: AnyObject {
    
}

final class IngredientsPageViewController: ViewController {
    // MARK: - Dummy data

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
                    ingredientName: "Шампиньоны",
                    ingredientMeasurement: "г",
                    ingredientAmount: 300
                ),
                IngredientInfo(
                    ingredientName: "Шампиньоны",
                    ingredientMeasurement: "г",
                    ingredientAmount: 300
                ),
                IngredientInfo(
                    ingredientName: "Шампиньоны",
                    ingredientMeasurement: "г",
                    ingredientAmount: 300
                ),
                IngredientInfo(
                    ingredientName: "Шампиньоны",
                    ingredientMeasurement: "г",
                    ingredientAmount: 300
                ),
                IngredientInfo(
                    ingredientName: "Шампиньоны",
                    ingredientMeasurement: "г",
                    ingredientAmount: 300
                )
            ]
        )
    ]
    
    struct Section {
        enum Section {
            case recipe
        }
        enum Row {
            case description(IngredientsDescriptionCellViewModel)
            case ingredients(IngredientsListCellViewModel)
        }
        
        let section: Section
        let rows: [Row]
    }
    
    // MARK: - Properties
    let interactor: IngredientsPageBusinessLogic
    var sections: [Section] = []
    var state: State {
        didSet {
            updateState()
        }
    }
    
    // MARK: - Views
    lazy var mainView: IngredientsPageView = {
        let view = IngredientsPageView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(interactor: IngredientsPageBusinessLogic, state: State) {
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
        navigationItem.title = ""
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
        
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
