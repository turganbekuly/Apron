//
//  AuthSignInView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import APRUIKit

protocol SignInProtocol: AnyObject {
    func signInTapped(email: String, password: String)
}

final class AuthSignInView: UIView {
    // MARK: - Properties

    weak var delegate: SignInProtocol?

    // MARK: - Initialization

    init(delegate: SignInProtocol?) {
        self.delegate = delegate
        super.init(frame: .zero)

        setupViews()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Views factory

    lazy var emailTextField: LoginTextField = {
        let textField = LoginTextField(
            placeholder: L10n.Authorization.Email.tfPlaceholder,
            title: L10n.Authorization.Email.tfTitle
        )
        return textField
    }()

    lazy var passwordTextField: LoginTextField = {
        let textField = LoginTextField(
            placeholder: L10n.Authorization.Password.tfPlaceholder,
            title: L10n.Authorization.Password.tfTitle
        )
        textField.textField.isSecureTextEntry = true
        return textField
    }()

    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 22
        button.setBackgroundColor(APRAssets.mainAppColor.color, for: .normal)
        button.titleLabel?.font = TypographyFonts.regular16
        button.setTitleColor(.white, for: .normal)
        button.setTitle(L10n.Authorization.SignIn.title, for: .normal)
        return button
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        [emailTextField, passwordTextField, continueButton].forEach { addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        emailTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(65)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(65)
        }

        continueButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }

    // MARK: - User actions

    @objc
    private func continueButtonTapped() {
        delegate?.signInTapped(
            email: emailTextField.textField.text ?? "",
            password: passwordTextField.textField.text ?? ""
        )
    }
}
