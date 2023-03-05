//
//  UpdateUsernameViewController.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 03.03.2023.
//

import UIKit
import APRUIKit
import AlertMessages
import Models

final class UpdateUsernameViewController: ViewController {

    // MARK: - Public properties

    var completion: (Bool) -> Void

    var provider: ViewControllerProviderProtocol

    var state: State {
        didSet {
            updateState()
        }
    }

    // MARK: - Init

    init(
        state: State,
        completion: @escaping (Bool) -> Void,
        provider: ViewControllerProviderProtocol = ViewControllerProvider()
    ) {
        self.state = state
        self.completion = completion
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        state = { state }()
        view.isOpaque = false
        view.backgroundColor = .black.withAlphaComponent(0.30)
        showUsernameUpdate(
            type: .completeAppleSignin(
                "Привет!",
                "Заполните ваше имя для продолжения",
                "Продолжить",
                "Позже"
            ),
            updateButton: { [weak self] text in
                guard let self = self else { return }
                var user = User()
                user.username = text
                self.updateProfile(with: user)
            },
            skipButton: { [weak self] in
                guard let self = self else { return }
                self.view.isUserInteractionEnabled = true
                self.hideLoader()
                self.dismiss(animated: true) {
                    self.completion(false)
                }
            }
        )
    }

    // MARK: - Method

    private func updateProfile(with user: User) {
        provider.updateProfile(body: user) { result in
            switch result {
            case let .success(model):
                self.state = .updateProfileSucceed(model)
            case .failed:
                self.state = .updateProfileFailed
            }
        }
    }
}
