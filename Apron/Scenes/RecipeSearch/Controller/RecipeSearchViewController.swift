//
//  RecipeSearchViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models
import AlertMessages
import Extensions
import UIScrollView_InfiniteScroll

protocol RecipeSearchDisplayLogic: AnyObject {
    func displayRecipes(with viewModel: RecipeSearchDataFlow.GetRecipes.ViewModel)
    func displaySaveRecipe(viewModel: RecipeSearchDataFlow.SaveRecipe.ViewModel)
}

final class RecipeSearchViewController: ViewController, Messagable {
    
    struct Section {
        enum Section {
            case filter
            case trendings
        }
        enum Row {
            case trending(String)
            case shimmer
            case result(RecipeResponse)
        }
        
        var section: Section
        var rows: [Row]
    }
    
    // MARK: - Properties
    private var isFirstAppear = true

    var throttler = Throttler(minimumDelay: 0.3)

    var currentPage = 1

    var query: String? {
        didSet {
            handleNewQuery(query: query)
        }
    }

    var filters = SearchFilterRequestBody()

    var filtersCount: Int = 0

    var recipesList: [RecipeResponse] = []
    
    let interactor: RecipeSearchBusinessLogic

    lazy var sections: [Section] = [
        .init(section: .trendings, rows: trends.compactMap { .trending($0) })
    ]

    var state: State {
        didSet {
            updateState()
        }
    }

    var trends = [String]()
    
    // MARK: - Views
    lazy var searchBar: APSearchBar = {
        let searchBar = APSearchBar()
        searchBar.delegate = self
        return searchBar
    }()

    lazy var mainView: RecipeSearchView = {
        let view = RecipeSearchView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(interactor: RecipeSearchBusinessLogic, state: State) {
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

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }
    
    // MARK: - Methods
    private func configureNavigation() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        if isFirstAppear == true {
            searchBar.becomeFirstResponder()
            isFirstAppear = false
        }
    }
    
    private func configureViews() {
        [mainView, searchBar].forEach { view.addSubview($0) }

        searchBar.clearButtonMode = .whileEditing
        searchBar.canceButtonMode = .always
        searchBar.placeholder = "Поиск по рецептам"
        mainView.addInfiniteScroll { [weak self] _ in
            guard let self = self else { return }
            self.filters.query = self.query ?? ""
            self.filters.page = self.currentPage
            self.getRecipes(filters: self.filters)
        }

        searchBar.onTouchedCancelButton = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            $0.leading.trailing.equalToSuperview()
        }

        mainView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func configureColors() {
        view.backgroundColor = ApronAssets.secondary.color
    }
    
    deinit {
        NSLog("deinit \(self)")
    }

    // MARK: - Private methods

    private func handleNewQuery(query: String?) {
        guard let query = query else { return }
        recipesList.removeAll()
        currentPage = 1
        sections = [
            .init(section: .filter, rows: [.shimmer])
        ]
        mainView.reloadData()

        filters.query = query
        filters.page = currentPage
        throttler.throttle { [weak self] in
            guard let self = self else { return }
            self.getRecipes(filters: self.filters)
        }
    }
}
