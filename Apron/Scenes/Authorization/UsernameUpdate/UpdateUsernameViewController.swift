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
import IQKeyboardManagerSwift
import PanModal
import SnapKit

final class UpdateUsernameViewController: ViewController, PanModalPresentable, MCKeyboardHelperDelegate {

    // MARK: - Public properties

    var completion: (Bool) -> Void

    var provider: ViewControllerProviderProtocol

    var state: State {
        didSet {
            updateState()
        }
    }

    // MARK: - Private properties

    private lazy var keyboardHelper = MCKeyboardHelper(delegate: self)
    private var bottomConstraint: Constraint?

    private var keyboardHeight: CGFloat = 0
    private var isTyping = false

    // MARK: - PanModal properties

    var panScrollable: UIScrollView? {
        return nil
    }

    var longFormHeight: PanModalHeight {
        if isTyping {
            return .contentHeightIgnoringSafeArea(mainView.frame.height + keyboardHeight)
        }

        return .contentHeightIgnoringSafeArea(mainView.frame.height)
    }

    var cornerRadius: CGFloat {
        return 32
    }

    var springDamping: CGFloat {
        return 1
    }

    var transitionDuration: Double {
        return 0.4
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

    override func loadView() {
        super.loadView()
        setupViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardHelper = { keyboardHelper }()
        state = { state }()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        panModalSetNeedsLayoutUpdate()
        panModalTransition(to: .longForm)
        mainView.roundedTextField.textField.becomeFirstResponder()
    }

    // MARK: - Views factory

    private lazy var mainView = UpdateUsernameView()

    // MARK: - Setup Views

    private func setupViews() {
        view.backgroundColor = APRAssets.secondary.color
        view.addSubviews(mainView)
        mainView.onSaveButtonTapped = { [weak self] username in
            guard let self = self else { return }
            var user = User()
            user.username = username
            self.updateProfile(with: user)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        mainView.snp.makeConstraints {
            $0.height.equalTo(210)
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
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

    // MARK: - Delegate

    public func keyboardWillAppear(_ info: MCKeyboardAppearanceInfo) {
        UIView.animate(
            withDuration: TimeInterval(info.animationDuration),
            delay: 0,
            options: info.animationOptions,
            animations: { [weak self] in
                guard let self = self else { return }
                self.keyboardHeight = info.endFrame.size.height
                UIView.animate(
                    withDuration: 0.1,
                    animations: {
                        self.view.layoutIfNeeded()
                    }
                )
                self.isTyping = true
                self.panModalSetNeedsLayoutUpdate()
                self.panModalTransition(to: .longForm)
            },
            completion: nil
        )
    }

    public func keyboardWillDisappear(_ info: MCKeyboardAppearanceInfo) {
        UIView.animate(
            withDuration: TimeInterval(info.animationDuration),
            delay: 0,
            options: info.animationOptions,
            animations: { [weak self] in
                guard let self = self else { return }
                UIView.animate(
                    withDuration: 0.1,
                    animations: {
                        self.view.layoutIfNeeded()
                    }
                )
                self.isTyping = false
                self.panModalSetNeedsLayoutUpdate()
                self.panModalTransition(to: .longForm)
            },
            completion: nil
        )
    }
}


