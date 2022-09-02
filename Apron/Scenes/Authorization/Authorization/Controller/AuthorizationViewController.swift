//
//  AuthorizationViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import Protocols
import UIKit
import SnapKit
import AlertMessages

protocol AuthorizationDisplayLogic: AnyObject {
    func login(viewModel: AuthorizationDataFlow.AuthorizationWithApple.ViewModel)
}

final class AuthorizationViewController: ViewController, Messagable {
    // MARK: - Properties
    let interactor: AuthorizationBusinessLogic

    var state: State {
        didSet {
            updateState()
        }
    }
    
    // MARK: - Views

    private lazy var skipButton: NavigationButton = {
        let button = NavigationButton()
        button.setTitle(L10n.Common.Skip.title, for: .normal)
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var mainView: AuthorizationView = {
        let view = AuthorizationView(delegate: self)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    // MARK: - Init
    init(interactor: AuthorizationBusinessLogic, state: State) {
        self.interactor = interactor
        self.state = state
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }
    
    // MARK: - Life Cycle
    override  func loadView() {
        super.loadView()
        
        configureViews()
    }

    override  func viewDidLoad() {
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
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: skipButton)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        skipButton.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(100)
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
        
    }

    // MARK: - User actions

    @objc
    private func skipButtonTapped() {
        let alert = UIAlertController(
            title: L10n.Authorization.Skip.title,
            message: L10n.Authorization.Skip.message,
            preferredStyle: .alert
        )
        let yesAction = UIAlertAction(
            title: L10n.Common.yes,
            style: .default
        ) { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }

                if self.presentingViewController != nil {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    let viewController = TabBarBuilder(state: .initial(.normal)).build()
                    DispatchQueue.main.async {
                        UIApplication.shared.windows.first?.rootViewController = viewController
                    }
                }
            }
        }
        let noAction = UIAlertAction(
            title: L10n.Common.no,
            style: .cancel
        )
        [noAction, yesAction].forEach {
            alert.addAction($0)
        }
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    deinit {
        NSLog("deinit \(self)")
    }
    
}
