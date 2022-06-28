//
//  AddSavedRecipesViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models

protocol AddSavedRecipesDisplayLogic: AnyObject {
    func displaySavedRecipes(with viewModel: AddSavedRecipesDataFlow.GetSavedRecipe.ViewModel)
    func displayCommunityRecipes(with viewModel: AddSavedRecipesDataFlow.AddToCommunity.ViewModel)
}

final class AddSavedRecipesViewController: ViewController {
    
    struct Section {
        enum Section {
            case recipes
        }
        enum Row {
            case recipe(RecipeResponse)
            case empty
            case loading
        }

        var section: Section
        var rows: [Row]
    }
    
    // MARK: - Properties
    let interactor: AddSavedRecipesBusinessLogic
    var sections: [Section] = [
        .init(section: .recipes, rows: Array(repeating: .loading, count: 10))
    ]
    var state: State {
        didSet {
            updateState()
        }
    }

    var savedRecipes: [RecipeResponse] = []
    var currentPage = 1
    var selectedRecipes: [Int] = [] {
        didSet {
            if selectedRecipes.isEmpty {
                navigationRightButton.backgroundType = .whiteBackground
                navigationRightButton.setTitle("Пропустить", for: .normal)
            } else {
                navigationRightButton.backgroundType = .blackBackground
                navigationRightButton.setTitle("Добавить", for: .normal)
            }
        }
    }

    var initialState: AddSavedRecipesType? {
        didSet {
            switch initialState {
            case let .community(id):
                self.communityID = id
            default:
                break
            }
        }
    }

    var communityID = 0
    
    // MARK: - Views

    private lazy var navigationRightButton: NavigationButton = {
        let button = NavigationButton()
        button.backgroundType = .whiteBackground
        button.setTitle("Пропустить", for: .normal)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var backButton = NavigationBackButton()

    lazy var mainView: AddSavedRecipesView = {
        let view = AddSavedRecipesView()
        view.dataSource = self
        view.delegate = self
        view.refreshControl = refreshControl
        return view
    }()

    public lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return view
    }()
    
    // MARK: - Init
    init(interactor: AddSavedRecipesBusinessLogic, state: State) {
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
        backButton.configure(with: "Добавить рецепт")
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
        [mainView].forEach { view.addSubview($0) }

        mainView.addInfiniteScroll { [weak self] _ in
            guard let self = self else { return }
            self.getSavedRecipes(page: self.currentPage)
        }

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
    private func refresh(_ sender: UIRefreshControl) {
        savedRecipes.removeAll()
        sections = [.init(section: .recipes, rows: Array(repeating: .loading, count: 10))]
        mainView.reloadData()
        currentPage = 1
        getSavedRecipes(page: currentPage)
    }

    @objc
    private func saveButtonTapped() {
        navigationRightButton.startAnimating()
        addToCommunity(communityID: communityID, recipes: selectedRecipes)
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
