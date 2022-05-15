//
//  GeneralSearchViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit

protocol GeneralSearchDisplayLogic: AnyObject {
    
}

final class GeneralSearchViewController: ViewController {
    
    struct Section {
        enum Section {
            
        }
        enum Row {
            
        }
        
        let section: Section
        let rows: [Row]
    }
    
    // MARK: - Properties
    let interactor: GeneralSearchBusinessLogic

    var sections: [Section] = []
    var searchSections: [SearchResultViewController.Section] = [] {
        didSet {
            (searchController.searchResultsController as? SearchResultViewController)?.sections = searchSections
        }
    }

    var state: State {
        didSet {
            updateState()
        }
    }

    private var isFirstAppear = true

    var initialState: GeneralSearchInitialState? {
        didSet {
            switch initialState {
            case .everything:
                print("asd")
            case .recipe:
                print("asd")
            case .saved:
                print("asd")
            default:
                break
            }
        }
    }
    
    // MARK: - Views

    lazy var mainView: GeneralSearchView = {
        let view = GeneralSearchView()
        view.dataSource = self
        view.delegate = self
        return view
    }()

    public lazy var searchController: SearchController = {
        let searchController = GeneralSearchResultBuilder(
            state: .initial(.main)
        ).build()
        let controller = SearchController(searchResultsController: searchController)
        controller.definesPresentationContext = true
        controller.hidesNavigationBarDuringPresentation = false
        controller.obscuresBackgroundDuringPresentation = true
        controller.searchBar.placeholder = "Поиск рецептов и сообществ"
        controller.searchResultsUpdater = self
        controller.searchBar.delegate = self
        return controller
    }()
    
    // MARK: - Init
    init(interactor: GeneralSearchBusinessLogic, state: State) {
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFirstAppear {
            searchController.searchBar.becomeFirstResponder()
            isFirstAppear = false
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }
    
    // MARK: - Methods

    private func search(term: String) {
        searchController.searchBar.text = term
        
    }

    private func configureNavigation() {
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
    }
    
    private func configureViews() {
        [mainView].forEach { view.addSubview($0) }
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func configureColors() {
        view.backgroundColor = Assets.secondary.color
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
