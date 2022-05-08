//
//  MainViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import DesignSystem
import UIKit
import AlertMessages
import Storages

public protocol MainDisplayLogic: AnyObject {
    
}

public final class MainViewController: ViewController, Messagable {
    // MARK: - Properties
    public let interactor: MainBusinessLogic

    public var state: State {
        didSet {
            updateState()
        }
    }

    lazy var sections: [Section] = [
        .init(section: .my, rows: [.myCommunities]),
        .init(section: .featured, rows: [.featuredCommunities]),
        .init(section: .quickSimple, rows: [.quickSimpleCommunities]),
        .init(section: .healthy, rows: [.healthyCommunities]),
        .init(section: .homemade, rows: [.homemadeCommunities])
    ]

    lazy var communitiesSection: [CommunitySection] = [
        .init(section: .myCommunities, rows: myRecipes[0].compactMap { .community($0) }),
        .init(section: .featuredCommunities, rows: myRecipes[1].compactMap { .community($0) }),
        .init(section: .quickSimpleCommunities, rows: myRecipes[2].compactMap { .community($0) }),
        .init(section: .healthyCommunities, rows: myRecipes[3].compactMap { .community($0) }),
        .init(section: .homemadeCommunities, rows: myRecipes[4].compactMap { .community($0) })
    ]

    var myCommunitySections: [CommunitySection] = [] {
        didSet {
            configureMyComSection()
        }
    }

    var featuredCommunitySections: [CommunitySection] = [] {
        didSet {
            configureFeaturedComSection()
        }
    }

    var quickCommunitySections: [CommunitySection] = [] {
        didSet {
            configureQuickComSection()
        }
    }

    var healthCommunitySections: [CommunitySection] = [] {
        didSet {
            configureHealthComSection()
        }
    }

    var homeCommunitySections: [CommunitySection] = [] {
        didSet {
            configureHomeComSection()
        }
    }

    var myRecipes = [[
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "1",
            membersCount: "199999",
            onJoinButtonTapped: nil,
            isMyCommunity: true
        ),
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "2",
            membersCount: "199999",
            onJoinButtonTapped: nil,
            isMyCommunity: true
        ),
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "3",
            membersCount: "199999",
            onJoinButtonTapped: nil,
            isMyCommunity: true
        ),
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "4",
            membersCount: "199999",
            onJoinButtonTapped: nil,
            isMyCommunity: true
        )
    ], [
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "5",
            membersCount: "199999",
            onJoinButtonTapped: nil
        ),
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "6",
            membersCount: "199999",
            onJoinButtonTapped: nil
        ),
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "7",
            membersCount: "199999",
            onJoinButtonTapped: nil
        ),
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "8",
            membersCount: "199999",
            onJoinButtonTapped: nil
        )
    ], [
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "9",
            membersCount: "199999",
            onJoinButtonTapped: nil
        ),
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "10",
            membersCount: "199999",
            onJoinButtonTapped: nil
        ),
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "11",
            membersCount: "199999",
            onJoinButtonTapped: nil
        ),
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "12",
            membersCount: "199999",
            onJoinButtonTapped: nil
        )
    ], [
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "13",
            membersCount: "199999",
            onJoinButtonTapped: nil
        ),
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "14",
            membersCount: "199999",
            onJoinButtonTapped: nil
        ),
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "15",
            membersCount: "199999",
            onJoinButtonTapped: nil
        ),
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "16",
            membersCount: "199999",
            onJoinButtonTapped: nil
        )
    ], [
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "17",
            membersCount: "199999",
            onJoinButtonTapped: nil
        ),
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "18",
            membersCount: "199999",
            onJoinButtonTapped: nil
        ),
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "19",
            membersCount: "199999",
            onJoinButtonTapped: nil
        ),
        CommunityCollectionCellViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "TikTok community",
            recipeCount: "20",
            membersCount: "199999",
            onJoinButtonTapped: nil
        )
    ]]

    
    public var selectedIndexPath = IndexPath(row: .zero, section: .zero)
    
    // MARK: - Views

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

    public lazy var mainView: MainView = {
        let view = MainView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Init
    public init(interactor: MainBusinessLogic, state: State) {
        self.interactor = interactor
        self.state = state
        
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Life Cycle
    override public func loadView() {
        super.loadView()
        
        configureViews()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        state = { state }()

        CartManager.shared.resetCart()
        ["Картошка", "Свекла", "Сахар", "Мука"].forEach {
            CartManager.shared.update(
                productName: $0,
                amount: 2,
                quantity: 1,
                measurement: "кг",
                recipeName: "Борщь"
            )
        }
        CartManager.shared.update(
            productName: "Картошка",
            amount: 3,
            quantity: 2,
            measurement: "кг",
            recipeName: "Манты"
        )
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigation()
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        configureColors()
    }
    
    // MARK: - Setup Views
    private func configureNavigation() {
        let avatarView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        avatarView.image = Assets.navAvatarIcon.image
        avatarView.layer.cornerRadius = 17
        avatarView.backgroundColor = .green
        let cartView = CartButtonView()
        cartView.onTap = { [weak self] in
            let viewController = ShoppingListBuilder(state: .initial).build()

            DispatchQueue.main.async {
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: avatarView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartView)
        navigationController?.navigationBar.barTintColor = Assets.secondary.color
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

    // MARK: - Methods

    public func configureMyComSection() {
        guard
            let section = sections.firstIndex(where: { $0.section == .my }),
            let row = sections[section].rows.firstIndex(where: { $0 == .myCommunities }),
            let cell = mainView.cellForRow(at: .init(row: row, section: section)) as? MyCommunityCell
        else { return }

        cell.communityCollectionView.reloadData()
    }

    public func configureFeaturedComSection() {
        guard
            let section = sections.firstIndex(where: { $0.section == .featured }),
            let row = sections[section].rows.firstIndex(where: { $0 == .featuredCommunities }),
            let cell = mainView.cellForRow(at: .init(row: row, section: section)) as? FeaturedCommunityCell
        else { return }

        cell.communityCollectionView.reloadData()
    }

    public func configureQuickComSection() {
        guard
            let section = sections.firstIndex(where: { $0.section == .quickSimple }),
            let row = sections[section].rows.firstIndex(where: { $0 == .quickSimpleCommunities }),
            let cell = mainView.cellForRow(at: .init(row: row, section: section)) as? QuickCommunityCell
        else { return }

        cell.communityCollectionView.reloadData()
    }

    public func configureHealthComSection() {
        guard
            let section = sections.firstIndex(where: { $0.section == .healthy }),
            let row = sections[section].rows.firstIndex(where: { $0 == .healthyCommunities }),
            let cell = mainView.cellForRow(at: .init(row: row, section: section)) as? HealthyCommunityCell
        else { return }

        cell.communityCollectionView.reloadData()
    }

    public func configureHomeComSection() {
        guard
            let section = sections.firstIndex(where: { $0.section == .homemade }),
            let row = sections[section].rows.firstIndex(where: { $0 == .homemadeCommunities }),
            let cell = mainView.cellForRow(at: .init(row: row, section: section)) as? HomemadeCommunityCell
        else { return }

        cell.communityCollectionView.reloadData()
    }

    deinit {
        NSLog("deinit \(self)")
    }
}
