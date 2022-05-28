//
//  ResultListViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit
import Models
import UIScrollView_InfiniteScroll

protocol ResultListDisplayLogic: AnyObject {
    func displayRecipesByCommunityID(with viewModel: ResultListDataFlow.GetRecipesByCommunityID.ViewModel)
}

final class ResultListViewController: ViewController {
    
    struct Section {
        enum Section {
            case everything
            case communities
            case recipes
        }
        enum Row {
            case community
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

    var currentPage = 1

    var query: String? {
        didSet {
            switch initialState {
            case .everything:
                sections = [
                    .init(section: .everything, rows: Array(repeating: .loading, count: 10))
                ]
                mainView.reloadData()
            case .recipe, .recipesFromCommunityPage:
                sections = [
                    .init(section: .everything, rows: Array(repeating: .loading, count: 10))
                ]
                mainView.reloadData()
                getRecipesByCommunityId(id: id, currentPage: currentPage, query: query ?? "")
            case .community:
                sections = [
                    .init(section: .everything, rows: Array(repeating: .loading, count: 10))
                ]
                mainView.reloadData()
            default:
                break
            }
        }
    }

    var initialState: GeneralSearchInitialState? {
        didSet {
            switch initialState {
            case let .recipesFromCommunityPage(id):
                self.id = id
            default: break
            }
        }
    }

    var id = 0

    var recipesList: [RecipeResponse] = [] {
        didSet {
            sections = [.init(section: .recipes, rows: recipesList.compactMap { .recipe($0) })]
        }
    }
    
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
        view.backgroundColor = Assets.secondary.color
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
