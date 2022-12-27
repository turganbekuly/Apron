//
//  AuthSignUpView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import APRUIKit

protocol SignUpProtocol: AnyObject {
    func signUpTapped(username: String, email: String, password: String)
}

final class AuthSignUpView: UIView {
    // MARK: - Properties

    weak var delegate: SignUpProtocol?

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Views factory

    lazy var nicknameTextField: LoginTextField = {
        let textField = LoginTextField(placeholder: "Имя пользователя", title: "Имя пользователя")
        return textField
    }()

    lazy var emailTextField: LoginTextField = {
        let textField = LoginTextField(placeholder: "mymail@gmail.com", title: "Эл.почта")
        return textField
    }()

    lazy var passwordTextField: LoginTextField = {
        let textField = LoginTextField(placeholder: "***********", title: "Пароль")
        textField.textField.addTarget(self, action: #selector(passwordChanged(_:)), for: .editingChanged)
        return textField
    }()

    lazy var confirmTextField: LoginTextField = {
        let textField = LoginTextField(placeholder: "***********", title: "Подтвердите пароль")
        textField.textField.addTarget(self, action: #selector(passwordChanged(_:)), for: .editingChanged)
        return textField
    }()

    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 22
        button.setBackgroundColor(ApronAssets.mainAppColor.color, for: .normal)
        button.titleLabel?.font = TypographyFonts.regular16
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Регистрация", for: .normal)
        button.isEnabled = false
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

    private func isContinueButtonEnabled() {
        let passTF = passwordTextField.textField.text
        let conTF = confirmTextField.textField.text
        let usernameTF = nicknameTextField.textField.text
        let emailTF = emailTextField.textField.text

        if passTF?.isEmpty == false,
           conTF?.isEmpty == false,
           usernameTF?.isEmpty == false,
           emailTF?.isEmpty == false,
           passTF == conTF
        {
            continueButton.isEnabled = true
            return
        }
        continueButton.isEnabled = false
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }

    // MARK: - User actions

    @objc
    private func continueButtonTapped() {
        delegate?.signUpTapped(
            username: nicknameTextField.textField.text ?? "",
            email: emailTextField.textField.text ?? "",
            password: confirmTextField.textField.text ?? ""
        )
    }

    @objc
    private func passwordChanged(_ sender: UITextField) {
        isContinueButtonEnabled()
    }
}
