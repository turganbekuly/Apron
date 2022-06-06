//
//  AuthSignUpView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import DesignSystem

protocol SignUpProtocol: AnyObject {
    func signUpTapped()
}

final class AuthSignUpView: UIView {
    // MARK: - Properties

    weak var delegate: SignUpProtocol?

    // MARK: - Initialization

    init(delegate: SignUpProtocol?) {
        self.delegate = delegate
        super.init(frame: .zero)

        setupViews()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Views factory

    lazy var nicknameTextField: LoginTextField = {
        let textField = LoginTextField(placeholder: "displayName", title: "Display name")
        return textField
    }()

    lazy var emailTextField: LoginTextField = {
        let textField = LoginTextField(placeholder: "mymail@gmail.com", title: "E-mail")
        return textField
    }()

    lazy var passwordTextField: LoginTextField = {
        let textField = LoginTextField(placeholder: "***********", title: "Password")
        return textField
    }()

    lazy var confirmTextField: LoginTextField = {
        let textField = LoginTextField(placeholder: "***********", title: "Confirm Password")
        return textField
    }()

    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 22
        button.setBackgroundColor(ApronAssets.colorsYello.color, for: .normal)
        button.titleLabel?.font = TypographyFonts.regular16
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Регистрация", for: .normal)
        return button
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        [nicknameTextField, emailTextField, passwordTextField, confirmTextField, continueButton].forEach { addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        nicknameTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(65)
        }

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(65)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(65)
        }

        confirmTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(65)
        }

        continueButton.snp.makeConstraints {
            $0.top.equalTo(confirmTextField.snp.bottom).offset(20)
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
        delegate?.signUpTapped()
    }
}
