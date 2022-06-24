//
//  ResultListViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models
import UIScrollView_InfiniteScroll
import Extensions
import AlertMessages

protocol ResultListDisplayLogic: AnyObject {
    func displayRecipesByCommunityID(with viewModel: ResultListDataFlow.GetRecipesByCommunityID.ViewModel)
    func displayEverything(with viewModel: ResultListDataFlow.GetEverything.ViewModel)
    func displaySavedRecipes(with viewModel: ResultListDataFlow.GetSavedRecipes.ViewModel)
    func displayRecipes(with viewModel: ResultListDataFlow.GetRecipes.ViewModel)
    func displayCommunities(with viewModel: ResultListDataFlow.GetCommunities.ViewModel)
    func displaySaveRecipe(viewModel: ResultListDataFlow.SaveRecipe.ViewModel)
}

final class ResultListViewController: ViewController, Messagable {
    
    struct Section {
        enum Section {
            case everything
            case communities
            case recipes
        }
        enum Row {
            case community(CommunityResponse)
            case recipe(RecipeResponse)
            case loading
        }
        
        var section: Section
        var rows: [Row]
    }
    
    // MARK: - Properties
    let interactor: ResultListBusinessLogic
    var sections: [Section] = []
    var state: State {
        didSet {
            updateState()
        }
    }

    var throttler = Throttler(minimumDelay: 0.3)

    var currentPage = 1

    var query: String? {
        didSet {
            handleNewQuery(initialState: initialState, query: query)
        }
    }

    var sourceType: SearchMadeSourceType = .searchTab

    var initialState: GeneralSearchInitialState? {
        didSet {
            switch initialState {
            case .everything, .recipe, .community, .main:
                sourceType = .searchTab
            case .savedRecipes:
                sourceType = .savedTab
            case let .recipesFromCommunityPage(id):
                self.id = id
                sourceType = .communityPage
            default: break
            }
        }
    }

    var id = 0

    var recipesList: [RecipeResponse] = []

    var communitiesList: [CommunityResponse] = []

    // MARK: - Views
    lazy var mainView: ResultListView = {
        let view = ResultListView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(interactor: ResultListBusinessLogic, state: State) {
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

    }
    
    private func configureViews() {
        [mainView].forEach { view.addSubview($0) }

        mainView.addInfiniteScroll { [weak self] _ in
            guard let self = self else { return }
            self.getRecipesByCommunityId(
                id: self.id,
                currentPage: self.currentPage,
                query: self.query ?? ""
            )
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

    // MARK: - Private Methods

    private func handleNewQuery(initialState: GeneralSearchInitialState?, query: String?) {
        switch initialState {
        case .everything:
            sections = [
                .init(section: .everything, rows: Array(repeating: .loading, count: 10))
            ]
            mainView.reloadData()
            throttler.throttle { [weak self] in
                guard let self = self else { return }
                self.getEverything(query: self.query ?? "")
            }
        case .recipesFromCommunityPage:
            sections = [
                .init(section: .recipes, rows: Array(repeating: .loading, count: 10))
            ]
            mainView.reloadData()
            throttler.throttle { [weak self] in
                guard let self = self else { return }
                self.getRecipesByCommunityId(
                    id: self.id,
                    currentPage: self.currentPage,
                    query: self.query ?? ""
                )
            }
        case .community:
            sections = [
                .init(section: .communities, rows: Array(repeating: .loading, count: 10))
            ]
            mainView.reloadData()
            throttler.throttle { [weak self] in
                guard let self = self else { return }
                self.getCommunities(
                    currentPage: self.currentPage,
                    query: self.query ?? ""
                )
            }
        case .savedRecipes:
            sections = [
                .init(section: .recipes, rows: Array(repeating: .loading, count: 10))
            ]
            mainView.reloadData()
            throttler.throttle { [weak self] in
                guard let self = self else { return }
                self.getSavedRecipes(
                    currentPage: self.currentPage,
                    query: self.query ?? ""
                )
            }
        case .recipe:
            sections = [
                .init(section: .recipes, rows: Array(repeating: .loading, count: 10))
            ]
            mainView.reloadData()
            throttler.throttle { [weak self] in
                guard let self = self else { return }
                self.getRecipes(
                    currentPage: self.currentPage,
                    query: self.query ?? ""
                )
            }
        default:
            break
        }
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
