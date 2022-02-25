//
//  SearchViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit

protocol SearchDisplayLogic: AnyObject {
    
}

final class SearchViewController: ViewController {
    
    struct Section {
        enum Section {
            
        }
        enum Row {
            
        }
        
        let section: Section
        let rows: [Row]
    }
    
    // MARK: - Properties
    let interactor: SearchBusinessLogic
    var sections: [Section] = []
    var state: State {
        didSet {
            updateState()
        }
    }
    var searchTypes: SearchTypes?
    
    // MARK: - Views
    lazy var mainView: SearchView = {
        let view = SearchView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    init(interactor: SearchBusinessLogic, state: State) {
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

    // MARK: - Views factory

    public lazy var searchController: SearchController = {
        let searchController = SearchResultBuilder(state: .initial).build()
//        (searchController as? SearchResultViewController)?.delegate = self
        let controller = SearchController(searchResultsController: searchController)
        controller.definesPresentationContext = true
        controller.hidesNavigationBarDuringPresentation = false
        controller.obscuresBackgroundDuringPresentation = true
        controller.searchBar.placeholder = "Поиск рецептов и сообществ"
//        controller.searchBar.delegate = self
        return controller
    }()
    
    // MARK: - Methods
    private func configureNavigation() {
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
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
        view.backgroundColor = Assets.secondary.color
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
