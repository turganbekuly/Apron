//
//  SearchByIngredientsResultViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models

protocol SearchByIngredientsResultDisplayLogic: AnyObject {
    func displayRecipes(with viewModel: SearchByIngredientsResultDataFlow.GetRecipesByIngredients.ViewModel)
}

final class SearchByIngredientsResultViewController: ViewController {
    
    struct Section {
        enum Section {
            case recipes(String)
        }
        enum Row {
            case recipe(RecipeResponse)
            case loading
            case empty
        }
        
        let section: Section
        let rows: [Row]
    }
    
    // MARK: - Properties
    let interactor: SearchByIngredientsResultBusinessLogic
    lazy var sections: [Section] = [
        .init(section: .recipes(""), rows: Array(repeating: .loading, count: 10))
    ] {
        didSet {
            mainView.reloadData()
        }
    }
    var state: State {
        didSet {
            updateState()
        }
    }
    
    var recipes: [RecipeResponse] = [] {
        didSet {
            var sections = [Section]()
            var sortedDictionary: [Double: [RecipeResponse]] = [:]
            for recipe in recipes {
                if var categoryRecipes = sortedDictionary[recipe.sort ?? 0] {
                    categoryRecipes.append(recipe)
                    sortedDictionary[recipe.sort ?? 0] = categoryRecipes
                } else {
                    sortedDictionary[recipe.sort ?? 0] = [recipe]
                }
            }
            
            for recipe in sortedDictionary {
                sections.append(
                    .init(
                        section: .recipes("\(Int(recipe.key)) ваших продуктов нашлись в этих рецептах"),
                        rows: recipe.value.compactMap { .recipe($0) }
                    )
                )
            }
            
            self.sections = sections
        }
    }
    
    // MARK: - Views
    
    private lazy var backButton = NavigationBackButton()
    
    lazy var mainView: SearchByIngredientsResultView = {
        let view = SearchByIngredientsResultView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(interactor: SearchByIngredientsResultBusinessLogic, state: State) {
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
        backButton.configure(with: "Найденные рецепты")
        backButton.onBackButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.backgroundColor = APRAssets.secondary.color
        tabBarController?.tabBar.isHidden = true
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
