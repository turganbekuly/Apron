//
//  CommunitiesListViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models
import UIScrollView_InfiniteScroll

protocol CommunitiesListDisplayLogic: AnyObject {
    func displayCommunities(viewModel: CommunitiesListDataFlow.GetCommunities.ViewModel)
}

final class CommunitiesListViewController: ViewController {
    
    struct Section {
        enum Section {
            case communities
        }
        enum Row {
            case community(CommunityResponse)
        }
        
        var section: Section
        var rows: [Row]
    }
    
    // MARK: - Properties
    let interactor: CommunitiesListBusinessLogic
    var sections: [Section] = []
    var state: State {
        didSet {
            updateState()
        }
    }

    var initialState: CommunitiesListInitialState? {
        didSet {
            switch initialState {
            case let .all(id, name):
                self.id = id
                self.categoryName = name
            case .myCommunities:
                self.categoryName = L10n.Communities.MyCommunity.title
            default:
                break
            }
        }
    }

    var communities: [CommunityResponse] = []
    var currentPage = 1
    var id = 0 {
        didSet {
            self.getCommunities(with: id, currentPage: currentPage)
        }
    }

    var categoryName: String? {
        didSet {
            backButton.configure(with: categoryName ?? "")
        }
    }
    
    // MARK: - Views
    lazy var mainView: CommunitiesListView = {
        let view = CommunitiesListView()
        view.dataSource = self
        view.delegate = self
        return view
    }()

    private lazy var backButton = NavigationBackButton()
    
    // MARK: - Init
    init(interactor: CommunitiesListBusinessLogic, state: State) {
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
        backButton.onBackButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.backgroundColor = ApronAssets.secondary.color
    }
    
    private func configureViews() {
        [mainView].forEach { view.addSubview($0) }
        mainView.addInfiniteScroll { [weak self] _ in
            guard let self = self else { return }
            self.getCommunities(with: self.id, currentPage: self.currentPage)
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
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
