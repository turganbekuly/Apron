//
//  AuthSignUpViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import APRUIKit
import UIKit
import AlertMessages

protocol AuthSignUpDisplayLogic: AnyObject {
    func displaySignUp(with viewModel: AuthSignUpDataFlow.SignUp.ViewModel)
}

final class AuthSignUpViewController: ViewController {
    // MARK: - Properties

    let interactor: AuthSignUpBusinessLogic

    var state: State {
        didSet {
            updateState()
        }
    }

    // MARK: - Views
    lazy var mainView: AuthSignUpView = {
        let view = AuthSignUpView()
        view.delegate = self
        view.passwordTextField.textField.isSecureTextEntry = true
        view.confirmTextField.textField.isSecureTextEntry = true
        return view
    }()

    private lazy var backButton = NavigationBackButton()

    // MARK: - Init
    init(interactor: AuthSignUpBusinessLogic, state: State) {
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

    // MARK: - Methods
    private func configureNavigation() {
        backButton.configure(with: L10n.Authorization.Button.SignIn.title)
        backButton.onBackButtonTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: false)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.navigationBar.backgroundColor = .clear
    }

    private func configureViews() {
        [mainView].forEach { view.addSubview($0) }

        configureColors()
        makeConstraints()
    }

    private func makeConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }

    private func configureColors() {
        view.backgroundColor = APRAssets.secondary.color
    }

    deinit {
        NSLog("deinit \(self)")
    }

}

extension AuthSignUpViewController: SignUpProtocol {
    func signUpTapped(username: String, email: String, password: String) {
        signupRequest(username: username, email: email, password: password)
        view.endEditing(true)
        showLoader()
    }
}
