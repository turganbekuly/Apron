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
    func displayMyCommunities(viewModel: MainDataFlow.GetMyCommunities.ViewModel)
}

final class MainViewController: ViewController, Messagable {
    // MARK: - Properties
    let interactor: MainBusinessLogic

    var state: State {
        didSet {
            updateState()
        }
    }

    lazy var sections: [Section] = [
        .init(section: .myCommunity, rows: [.myCommunities([])]),
        .init(section: .communities, rows: [.communities("Сообщество", [], 0)])
    ]

    var dynamicCommunities: [CommunityCategory] = [] {
        didSet {
            configureCommunities()
        }
    }

    var myCommunities: [CommunityResponse] = [] {
        didSet {
            configureCommunities()
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

    private lazy var createCommunityButton: BlackOpButton = {
        let button = BlackOpButton(backgroundType: .yelloBackground)
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.setImage(ApronAssets.creationPlusButton.image, for: .normal)
        button.clipsToBounds = true
        return button
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
        avatarView.image = ApronAssets.navAvatarIcon.image
        avatarView.layer.cornerRadius = 17
        avatarView.backgroundColor = .green
        let cartView = CartButtonView()
        cartView.onTap = { [weak self] in
            guard let self = self else { return }
            let viewController = ShoppingListBuilder(state: .initial).build()

            DispatchQueue.main.async {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: avatarView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartView)
        navigationController?.navigationBar.barTintColor = ApronAssets.secondary.color
    }
    
    private func configureViews() {
        [mainView, createCommunityButton].forEach { view.addSubview($0) }
        
        configureColors()
        makeConstraints()
    }
    
    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        createCommunityButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.size.equalTo(50)
        }
    }
    
    private func configureColors() {
        view.backgroundColor = ApronAssets.secondary.color
    }

    // MARK: - User actions

    @objc
    private func createButtonTapped() {
        handleAuthorizationStatus {
            let vc = CreateActionFlowBuilder.init(state: .initial(.mainPageCommunityCreation, self)).build()
            DispatchQueue.main.async {
                self.navigationController?.presentPanModal(vc)
            }
        }
    }

    // MARK: - Methods

    private func configureCommunities() {
        var sections = [Section]()
        if !myCommunities.isEmpty {
            sections.append(
                .init(
                    section: .myCommunity, rows: [.myCommunities(myCommunities)]
                )
            )
        } else {
            sections.append(
                .init(
                    section: .myCommunity, rows: [.myCommunities([])]
                )
            )
        }


        if !dynamicCommunities.isEmpty {
            let _ = dynamicCommunities.compactMap { com in
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

        self.sections = sections
        mainView.reloadData()
    }

    // MARK: - User actions

    @objc
    private func refresh(_ sender: UIRefreshControl) {
        sections = [
            .init(section: .myCommunity, rows: [.myCommunities([])]),
            .init(section: .communities, rows: [.communities("Сообщество", [], 0)])
        ]
        mainView.reloadData()
        getMyCommunities()
        getCommunitiesByCategory()
    }

    deinit {
        NSLog("deinit \(self)")
    }
}
