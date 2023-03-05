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

protocol MainDisplayLogic: AnyObject {
    func displayCommunities(viewModel: MainDataFlow.GetCommunities.ViewModel)
    func displayCookNowRecipes(viewModel: MainDataFlow.GetCookNowRecipes.ViewModel)
    func displayEventRecipes(viewModel: MainDataFlow.GetEventRecipes.ViewModel)
    func displaySavedRecipe(viewModel: MainDataFlow.SaveRecipe.ViewModel)
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

    var dynamicCommunities: [CommunityCategory] = [] {
        didSet {
            configureCommunities()
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

            DispatchQueue.main.async {
                self.navigationController?.pushViewController(viewController, animated: false)
            }
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: avatarView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartView)
        navigationController?.navigationBar.barTintColor = ApronAssets.secondary.color

        if let myTabBar = tabBarController?.tabBar as? AppTabBar {
            myTabBar.centerButtonActionHandler = {
                self.handleAuthorizationStatus {
                    let vc = RecipeCreationBuilder(state: .initial(.create(RecipeCreation(), .saved))).build()
                    let navController = RecipeCreationNavigationController(rootViewController: vc)
                    navController.modalPresentationStyle = .fullScreen

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
        view.backgroundColor = ApronAssets.secondary.color
    }

    // MARK: - Methods

    private func configureCommunities() {
        var sections = [Section]()
        if !dynamicCommunities.isEmpty {
            _ = dynamicCommunities.compactMap { com in
                if let communities = com.communities, !communities.isEmpty {
                    sections.append(
                        .init(
                            section: .communities,
                            rows: [
                                .communities(
                                    com.name ?? "",
                                    com.communities ?? [],
                                    com.id
                                )
                            ]
                        )
                    )
                }
            }
        }

        sections.append(
            .init(section: .whatToCook, rows: [.whatToCook("Что приготовить?")])
        )
        self.sections = sections
        mainView.reloadTableViewWithoutAnimation()
    }

    func defineRecipeDayTime() -> SuggestedDayTimeType {
        let today = Date()
        let hour = Calendar.current.component(.hour, from: today)
        if (7...13).contains(hour) {
            return .zavtrak
        }
        if (13...15).contains(hour) {
            return .obed
        }
        if (16...18).contains(hour) {
            return .poldnik
        }
        if (19...23).contains(hour) {
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
        switch cookNowRecipesState {
        case .failed:
            break
        case .loading:
            sections.append(.init(section: .cookNow, rows: [.cookNow("", [])]))
        case let .loaded(recipes):
            if !recipes.isEmpty {
                sections.append(.init(section: .cookNow, rows: [.cookNow("Приготовить на \(defineRecipeDayTime().title.lowercased())", cookNowRecipes)]))
            }
        }

        switch eventRecipesState {
        case .failed:
            break
        case .loading:
            sections.append(.init(section: .cookNow, rows: [.cookNow("", [])]))
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
        sections.append(
            .init(section: .whatToCook, rows: [.whatToCook("Что приготовить?")])
        )
        self.sections = sections
    }

    // MARK: - User actions

    @objc
    private func refresh(_ sender: UIRefreshControl) {
        eventRecipes.removeAll()
        cookNowRecipes.removeAll()
        cookNowRecipesState = .loading
        getCookNowRecipes()
        fetchRemoteConfigFeatures()
    }

    deinit {
        NSLog("deinit \(self)")
    }
}
