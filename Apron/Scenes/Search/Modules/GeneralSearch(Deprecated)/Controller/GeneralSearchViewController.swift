//
//  GeneralSearchViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models

protocol ResultListViewControllerDelegate: AnyObject {
    func controller(_ contoller: UIViewController, didSelect recipe: RecipeResponse)
    func controller(_ controller: UIViewController, didSelect community: CommunityResponse)
}

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

    var state: State {
        didSet {
            updateState()
        }
    }

    private var isFirstAppear = true

    var initialState: GeneralSearchInitialState?

    var historySelectedQuery: String?

    // MARK: - Views

    lazy var mainView: GeneralSearchView = {
        let view = GeneralSearchView()
//        view.dataSource = self
//        view.delegate = self
        return view
    }()

    public lazy var searchController: SearchController = {
        let searchController = GeneralSearchResultBuilder(
            state: .initial(initialState ?? .main, self)
        ).build()
        let controller = SearchController(searchResultsController: searchController)
        controller.definesPresentationContext = true
        controller.hidesNavigationBarDuringPresentation = false
        controller.obscuresBackgroundDuringPresentation = true
        controller.searchBar.placeholder = L10n.Search.title
        controller.searchResultsUpdater = self
        controller.searchBar.delegate = self
        controller.delegate = self
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

    override func viewDidLoad() {
        super.viewDidLoad()

        state = { state }()
        configureViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureNavigation()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        searchController.isActive = true
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
//        navigationItem.titleView = searchController.searchBar
//        definesPresentationContext = true
    }

    private func configureViews() {
        [mainView].forEach { view.addSubview($0) }
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        configureColors()
        makeConstraints()
    }

    private func makeConstraints() {
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func configureColors() {
        view.backgroundColor = APRAssets.secondary.color
    }

    deinit {
        NSLog("deinit \(self)")
    }

}
