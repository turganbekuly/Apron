//
//  ProfileViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import Storages
import AlertMessages
import NVActivityIndicatorView
import FeatureToggle

protocol ProfileDisplayLogic: AnyObject {
    func displayProfile(with viewModel: ProfileDataFlow.GetProfile.ViewModel)
    func displayDeleteAccount(with viewModel: ProfileDataFlow.DeleteAccount.ViewModel)
}

final class ProfileViewController: ViewController {

    struct Section {
        enum Section {
            case app
        }
        enum Row {
            case user
            case bonus(Int)
            case assistant
            case deleteAccount
            case contactWithDevelopers
            case logout
            case myRecipes
            case favRecipes
        }

        let section: Section
        let rows: [Row]
    }

    // MARK: - Properties
    let interactor: ProfileBusinessLogic
    var sections: [Section] = []
    var state: State {
        didSet {
            updateState()
        }
    }

    var userStorage: UserStorageProtocol = UserStorage()

    // MARK: - Views
    lazy var mainView: ProfileView = {
        let view = ProfileView()
        view.dataSource = self
        view.delegate = self
        return view
    }()

    private lazy var activityIndicator = NVActivityIndicatorView(
        frame: .zero,
        type: .circleStrokeSpin,
        color: APRAssets.mainAppColor.color,
        padding: nil
    )

    // MARK: - Init
    init(interactor: ProfileBusinessLogic, state: State) {
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
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    deinit {
        NSLog("deinit \(self)")
    }

    // MARK: - Methods
    private func configureNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: APRAssets.navBackButton.image,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.backgroundColor = APRAssets.secondary.color
    }

    private func configureViews() {
        [mainView, activityIndicator].forEach { view.addSubview($0) }

        activityIndicator.isHidden = true
        activityIndicator.alpha = 0.0

        configureColors()
        makeConstraints()
    }

    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(24)
        }
    }

    private func configureColors() {
        view.backgroundColor = APRAssets.secondary.color
    }

    func isLoading(_ loading: Bool) {
        guard loading else {
            activityIndicator.isHidden = true
            activityIndicator.alpha = 0.0
            activityIndicator.stopAnimating()
            return
        }

        activityIndicator.isHidden = false
        activityIndicator.alpha = 1.0
        activityIndicator.startAnimating()
    }

    // MARK: - User actions 

    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: false)
    }
}
