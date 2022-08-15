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

protocol ProfileDisplayLogic: AnyObject {
    func displayProfile(with viewModel: ProfileDataFlow.GetProfile.ViewModel)
    func displayDeleteAccount(with viewModel: ProfileDataFlow.DeleteAccount.ViewModel)
}

final class ProfileViewController: ViewController, Messagable {
    
    struct Section {
        enum Section {
            case app
        }
        enum Row {
            case user
            case about
            case deleteAccount
            case logout
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

    public var userStorage: UserStorageProtocol = UserStorage()
    
    // MARK: - Views
    lazy var mainView: ProfileView = {
        let view = ProfileView()
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
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
            image: ApronAssets.navBackButton.image,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.backgroundColor = ApronAssets.secondary.color
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

    // MARK: - User actions

    @objc
    private func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
