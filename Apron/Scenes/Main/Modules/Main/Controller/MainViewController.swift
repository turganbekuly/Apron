//
//  MainViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import AlertMessages
import Storages
import Models
import RemoteConfig
import HapticTouch

protocol MainDisplayLogic: AnyObject {
    func displayCommunities(viewModel: MainDataFlow.GetCommunities.ViewModel)
    func displayCookNowRecipes(viewModel: MainDataFlow.GetCookNowRecipes.ViewModel)
    func displayEventRecipes(viewModel: MainDataFlow.GetEventRecipes.ViewModel)
    func displaySavedRecipe(viewModel: MainDataFlow.SaveRecipe.ViewModel)
    func displayCommunityById(viewModel: MainDataFlow.GetCommunity.ViewModel)
    func displayProductsByIds(viewModel: MainDataFlow.GetProductsByIDs.ViewModel)
}

final class MainViewController: ViewController {
    // MARK: - Properties
    let interactor: MainBusinessLogic

    let remoteConfigManager = RemoteConfigManager.shared.remoteConfig
    let configManager = RemoteConfigManager.shared.configManager

    var state: State {
        didSet {
            updateState()
        }
    }

    lazy var sections: [Section] = [] {
        didSet {
            endRefreshingIfNeeded()
            mainView.reloadData()
        }
    }
    
    var communities: [CommunityResponse] = [] {
        didSet {
            configureMainPageCells()
        }
    }
    
    var products: [Product] = [] {
        didSet {
            configureMainPageCells()
        }
    }

    var eventType = 0
    var adBanners: [AdBannerObject] = []
    var eventRecipes: [RecipeResponse] = [] {
        didSet {
            configureMainPageCells()
        }
    }

    var cookNowRecipes: [RecipeResponse] = [] {
        didSet {
            configureMainPageCells()
        }
    }

    var cookNowRecipesState = CookNowCellState.failed {
        didSet {
            configureMainPageCells()
        }
    }
    var eventRecipesState = CookNowCellState.failed {
        didSet {
            configureMainPageCells()
        }
    }
    
    var filters = SearchFilterRequestBody()
    var currentPage = 1

    // MARK: - Views

    lazy var mainView: MainView = {
        let view = MainView()
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
    init(interactor: MainBusinessLogic, state: State) {
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
        if AuthStorage.shared.isUserAuthorized {
            ApronAnalytics.shared.sendAnalyticsEvent(
                .homePageViewed(.loggedIn)
            )
        } else {
            ApronAnalytics.shared.sendAnalyticsEvent(
                .homePageViewed(.guest)
            )
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Setup Views
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

        mainView.addInfiniteScroll { [weak self] _ in
            guard let self = self else { return }
            self.filters.page = self.currentPage
            self.getCookNowRecipes(filters: self.filters)
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
        view.backgroundColor = APRAssets.secondary.color
    }

    // MARK: - Methods

    func defineRecipeDayTime() -> SuggestedDayTimeType {
        let today = Date()
        let hour = Calendar.current.component(.hour, from: today)
        if (7...11).contains(hour) {
            return .zavtrak
        }
        if (12...14).contains(hour) {
            return .obed
        }
        if (15...17).contains(hour) {
            return .poldnik
        }
        if (18...23).contains(hour) {
            return .uzhin
        }
        if (0...6).contains(hour) {
            return .uzhin
        }
        return .obed
    }

    func configureMainPageCells() {
        var sections = [Section]()
        if !adBanners.isEmpty {
            sections.append(.init(section: .adBanner, rows: [.adBanner(adBanners)]))
        }
        
        if !products.isEmpty {
            sections.append(
                .init(
                    section: .searchByIngredients,
                    rows: [.searchByIngredients(
                        L10n.SearchByIngredients.Main.Section.title,
                        L10n.SearchByIngredients.Main.Section.descr,
                        products + [Product()]
                    )]
                )
            )
        }
        
        sections.append(
            .init(section: .whatToCook, rows: [.whatToCook(L10n.Main.WhenToCook.title)])
        )
        
//        if !communities.isEmpty {
//            sections.append(
//                .init(
//                    section: .communities,
//                    rows: [
//                        .communities(L10n.Main.Communities.title, communities)
//                    ]
//                )
//            )
//        }

        switch eventRecipesState {
        case .failed:
            break
        case .loading:
            sections.append(.init(section: .eventRecipes, rows: [.eventRecipes("", [])]))
        case let .loaded(recipes):
            if !recipes.isEmpty {
                sections.append(
                    .init(
                        section: .eventRecipes,
                        rows: [.eventRecipes(SuggestedEventType(rawValue: eventType)?.title ?? "", eventRecipes)]
                    )
                )
            }
        }

        switch cookNowRecipesState {
        case .failed:
            break
        case .loading:
            sections.append(.init(section: .cookNow, rows: [.recipeLoader]))
        case let .loaded(recipes):
            if !recipes.isEmpty {
                sections.append(.init(section: .cookNow, rows: recipes.compactMap { .cookNow($0) }))
            }
        }
        
        self.sections = sections
    }

    // MARK: - User actions

    @objc
    private func refresh(_ sender: UIRefreshControl) {
        HapticTouch.generateLight()
        eventRecipes.removeAll()
        cookNowRecipes.removeAll()
        cookNowRecipesState = .loading
        getCookNowRecipes(filters: filters)
        fetchRemoteConfigFeatures()
    }

    deinit {
        NSLog("deinit \(self)")
    }
}
