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

protocol MainDisplayLogic: AnyObject {
    func displayJoinCommunity(viewModel: MainDataFlow.JoinCommunity.ViewModel)
}

final class MainViewController: ViewController, Messagable {
    // MARK: - Properties
    let interactor: MainBusinessLogic

    var state: State {
        didSet {
            updateState()
        }
    }

    lazy var sections: [Section] = []

    lazy var communitiesSection: [CommunitySection] = []

    var recipes: [CommunitiesCollectionViewModel]? {
        didSet {
            guard let myRecipes = recipes else { return }
            sections =  [.init(section: .communities, rows: myRecipes.compactMap { .communities($0.sectionTitle) })]
            mainView.reloadData()
        }
    }

    var myRecipes = [
        CommunitiesCollectionViewModel(
            sectionTitle: "Baking",
            communities: [
                CommunityCollectionCellViewModel(
                    imageURL: Assets.cmntImageview.image,
                    communityName: "Baking community 1",
                    recipeCount: "1",
                    membersCount: "199999",
                    onJoinButtonTapped: nil,
                    isMyCommunity: true
                ),
                CommunityCollectionCellViewModel(
                    imageURL: Assets.cmntImageview.image,
                    communityName: "Baking community 2",
                    recipeCount: "2",
                    membersCount: "199999",
                    onJoinButtonTapped: nil,
                    isMyCommunity: true
                ),
                CommunityCollectionCellViewModel(
                    imageURL: Assets.cmntImageview.image,
                    communityName: "Baking community 3",
                    recipeCount: "3",
                    membersCount: "199999",
                    onJoinButtonTapped: nil,
                    isMyCommunity: true
                ),
                CommunityCollectionCellViewModel(
                    imageURL: Assets.cmntImageview.image,
                    communityName: "Baking community 4",
                    recipeCount: "4",
                    membersCount: "199999",
                    onJoinButtonTapped: nil,
                    isMyCommunity: true
                )
            ]
        ),
        CommunitiesCollectionViewModel(
            sectionTitle: "Quick and Simple",
            communities: [
                CommunityCollectionCellViewModel(
                    imageURL: Assets.cmntImageview.image,
                    communityName: "Quick and Simple community 1",
                    recipeCount: "1",
                    membersCount: "199999",
                    onJoinButtonTapped: nil,
                    isMyCommunity: true
                ),
                CommunityCollectionCellViewModel(
                    imageURL: Assets.cmntImageview.image,
                    communityName: "Quick and Simple community 2",
                    recipeCount: "2",
                    membersCount: "199999",
                    onJoinButtonTapped: nil,
                    isMyCommunity: true
                ),
                CommunityCollectionCellViewModel(
                    imageURL: Assets.cmntImageview.image,
                    communityName: "Quick and Simple community 3",
                    recipeCount: "3",
                    membersCount: "199999",
                    onJoinButtonTapped: nil,
                    isMyCommunity: true
                ),
                CommunityCollectionCellViewModel(
                    imageURL: Assets.cmntImageview.image,
                    communityName: "Quick and Simple community 4",
                    recipeCount: "4",
                    membersCount: "199999",
                    onJoinButtonTapped: nil,
                    isMyCommunity: true
                )
            ]
        )
    ]
    
    // MARK: - Views

    lazy var mainView: MainView = {
        let view = MainView()
        view.dataSource = self
        view.delegate = self
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
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
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

//    public func configureMyComSection() {
//        guard
//            let section = sections.firstIndex(where: { $0.section == .myCommunity }),
//            let row = sections[section].rows.firstIndex(where: { $0 == .myCommunities }),
//            let cell = mainView.cellForRow(at: .init(row: row, section: section)) as? MyCommunityCell
//        else { return }
//
//        cell.communityCollectionView.reloadData()
//    }

    deinit {
        NSLog("deinit \(self)")
    }
}
