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
            case search
        }
        enum Row {
            case searchHistory
        }
        
        let section: Section
        let rows: [Row]
    }

    struct SearchHistorySection {
        enum Section {
            case searchHistory
        }
        enum Row {
            case history(SearchHistoryItem)
        }

        let section: Section
        let rows: [Row]
    }
    
    // MARK: - Properties
    let interactor: SearchBusinessLogic

    var sections: [Section] = []
    var historyCollectionCell: [SearchHistorySection] = []

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
        getSearchHistory()
        configureHistory()
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
            let viewController = ShoppingListBuilder(state: .initial).build()

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

    func configureHistory() {
        guard
            let section = sections.firstIndex(where: { $0.section == .search }),
            let row = sections[section].rows.firstIndex(of: .searchHistory),
            let cell = mainView.cellForRow(at: IndexPath(row: row, section: section)) as? SearchHistoryCell
        else { return }
        historyCollectionCell = [
            .init(section: .searchHistory, rows: searchHistoryItems.compactMap { .history($0) })
        ]
        cell.historyCollectionView.reloadData()
    }
    
}
