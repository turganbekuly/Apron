//
//  MarketplaceViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Models
import AlertMessages
import HapticTouch

protocol MarketplaceDisplayLogic: AnyObject {
    func displayItems(with viewModel: MarketplaceDataFlow.GetProducts.ViewModel)
}

final class MarketplaceViewController: ViewController {
    
    struct Section {
        enum Section {
            case items
        }
        enum Row {
            case item(MarketplaceItemResponseBody)
            case empty
            case loading
        }
        
        let section: Section
        let rows: [Row]
    }
    
    // MARK: - Properties
    let interactor: MarketplaceBusinessLogic
    
    lazy var sections: [Section] = [
        .init(
            section: .items,
            rows: Array(repeating: .loading, count: 10)
        )
    ] {
        didSet {
            mainView.reloadData()
        }
    }
    
    var state: State {
        didSet {
            updateState()
        }
    }
    
    var items: [MarketplaceItemResponseBody] = [] {
        didSet {
            sections = [
                .init(
                    section: .items,
                    rows: items.compactMap { .item($0) }
                )
            ]
        }
    }
    
    // MARK: - Views
    lazy var mainView: MarketplaceView = {
        let view = MarketplaceView()
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
    init(interactor: MarketplaceBusinessLogic, state: State) {
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
        
        ApronAnalytics.shared.sendAnalyticsEvent(.marketplacePageViewed)
        configureNavigation()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }
    
    // MARK: - Methods
    private func configureNavigation() {
        let avatarView = AvatarView()
        avatarView.onTap = { [weak self] in
            guard let self = self else { return }
            self.handleAuthorizationStatus {
                let viewController = ProfileBuilder(state: .initial).build()
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(viewController, animated: false)
                }
            }
        }

        let cartView = CartButtonView()
        cartView.onTap = { [weak self] in
            guard let self = self else { return }
            let viewController = ShoppingListBuilder(state: .initial(.regular)).build()

            HapticTouch.generateLight()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(viewController, animated: false)
            }
        }
        
        let bonusView = BonusView()
        bonusView.onBonusButtonTapped = { [weak self] in
            let vc = WebViewHandler(urlString: AppConstants.bonusLink)
            DispatchQueue.main.async {
                self?.presentPanModal(vc)
            }
        }
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: cartView),
            UIBarButtonItem(customView: bonusView)
        ]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: avatarView)
        navigationController?.navigationBar.barTintColor = APRAssets.secondary.color

        if let myTabBar = tabBarController?.tabBar as? AppTabBar {
            myTabBar.centerButtonActionHandler = {
                self.handleAuthorizationStatus {
                    let vc = RecipeCreationBuilder(state: .initial(.create(RecipeCreation(), .main))).build()
                    let navController = RecipeCreationNavigationController(rootViewController: vc)
                    navController.modalPresentationStyle = .fullScreen
                    HapticTouch.generateSuccess()
                    DispatchQueue.main.async {
                        self.navigationController?.present(navController, animated: true)
                    }
                }
            }
        }
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
        view.backgroundColor = APRAssets.secondary.color
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
    // MARK: - User actions

    @objc
    private func refresh(_ sender: UIRefreshControl) {
        HapticTouch.generateLight()
        getItems()
    }
}
