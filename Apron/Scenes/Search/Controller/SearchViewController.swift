//
//  SearchViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Storages

protocol SearchDisplayLogic: AnyObject {
    
}

final class SearchViewController: ViewController {
    
    struct Section {
        enum Section {
            case categories
        }
        enum Row {
            case category
        }
        
        let section: Section
        let rows: [Row]
    }

    struct CategoriesSection {
        enum Section {
            case categories
        }
        enum Row {
            case category(SearchSuggestionCategoriesTypes)
        }

        let section: Section
        let rows: [Row]
    }
    
    // MARK: - Properties
    let interactor: SearchBusinessLogic

    var sections: [Section] = []
    var categoryCollectionCell: [CategoriesSection] = [
        .init(section: .categories, rows: SearchSuggestionCategoriesTypes.allCases.compactMap { .category($0) })
    ]

    var state: State {
        didSet {
            updateState()
        }
    }
    var searchTypes: SearchTypes?
    var searchHistoryItems: [SearchHistoryItem] = []
    
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

    deinit {
        NSLog("deinit \(self)")
    }

    // MARK: - Views factory

    lazy var mainView: SearchView = {
        let view = SearchView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Methods
    private func configureNavigation() {
        let avatarView = AvatarView()
        avatarView.onTap = { [weak self] in
            guard let self = self else { return }
            self.handleAuthorizationStatus {
                let viewController = ProfileBuilder(state: .initial).build()
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
        }
        
        let cartView = CartButtonView()
        cartView.onTap = { [weak self] in
            let viewController = ShoppingListBuilder(state: .initial(.regular)).build()

            DispatchQueue.main.async {
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: avatarView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartView)
        navigationController?.navigationBar.barTintColor = ApronAssets.secondary.color
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
        view.backgroundColor = ApronAssets.secondary.color
    }

//    func configureCategories() {
//        guard
//            let section = sections.firstIndex(where: { $0.section == .categories }),
//            let row = sections[section].rows.firstIndex(of: .category),
//            let cell = mainView.cellForRow(at: IndexPath(row: row, section: section)) as? SearchSuggestionCategoriesCell
//        else { return }
//        historyCollectionCell = [
//            .init(section: .searchHistory, rows: searchHistoryItems.compactMap { .history($0) })
//        ]
//        cell.historyCollectionView.reloadData()
//    }
    
}
