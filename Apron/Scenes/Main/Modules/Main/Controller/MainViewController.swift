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
import Models

protocol MainDisplayLogic: AnyObject {
    func displayJoinCommunity(viewModel: MainDataFlow.JoinCommunity.ViewModel)
    func displayCommunities(viewModel: MainDataFlow.GetCommunities.ViewModel)
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
    lazy var myCommunitySection: [MyCommunitiesSection] = []

    var dynamicCommunities: [CommunityCategory] = [] {
        didSet {
            configureCommunities()
        }
    }

    var myCommunities: [MyCommunityCollectionViewModel] = [] {
        didSet {
            configureCommunities()
        }
    }

    var my = [
        MyCommunityCollectionViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "My community 1"
        ),
        MyCommunityCollectionViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "My community 2"
        ),
        MyCommunityCollectionViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "My community 3"
        ),
        MyCommunityCollectionViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "My community 4"
        ),
        MyCommunityCollectionViewModel(
            imageURL: Assets.cmntImageview.image,
            communityName: "My community 5"
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

    private func configureCommunities() {
        var sections = [Section]()

        if !myCommunities.isEmpty {
            myCommunitySection = [.init(section: .myCommunities, rows: myCommunities.compactMap { .myCommunity($0) })]
            sections.append(
                .init(
                    section: .myCommunity, rows: [.myCommunities(myCommunities.count >= 10 ? false : true)]
                )
            )
        }


        if !dynamicCommunities.isEmpty {
            dynamicCommunities.compactMap { com in
                if let communities = com.communities, !communities.isEmpty {
                    sections.append(
                        .init(
                            section: .communities,
                            rows: [
                                .communities(
                                    com.name ?? "",
                                    (com.communities?.count ?? 1) >= 10 ? false : true,
                                    com.communities ?? []
                                )
                            ]
                        )
                    )
                }
            }
        }

        self.sections = sections
        mainView.reloadData()
    }

    deinit {
        NSLog("deinit \(self)")
    }
}
