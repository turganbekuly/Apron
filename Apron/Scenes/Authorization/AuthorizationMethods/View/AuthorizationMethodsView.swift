//
//  AuthorizationMethodsView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import DesignSystem

public protocol IAuthorizationMethods: AnyObject {
    func methodSelected(in view: AuthorizationMethodsView, method type: AuthorizationMethodTypes)
}

public enum AuthorizationMethodTypes {
    case apple
    case google
    case facebook
    case email
}

public final class AuthorizationMethodsView: UIView {
    // MARK: - Properties

    weak var delegate: IAuthorizationMethods?
    var authorizationType: AuthorizationType? {
        didSet {
            titleLabel.text = authorizationType == .signin ? L10n.Authorization.SignIn.title : L10n.Authorization.SignUp.title
            subtitleLabel.text = "Войдите чтобы найти рецепты"
            continueButton.setTitle(authorizationType == .signin ? "Войти" : "Зарегистрироваться", for: .normal)
        }
    }
    
    // MARK: - Initialization
    public init(delegate: IAuthorizationMethods?) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        setupViews()
    }
    
    public required init?(coder: NSCoder) {
        return nil
    }

    // MARK: - Views factory
    lazy var topHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = Assets.colorsYello.color
        view.layer.cornerRadius = 8
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = TypographyFonts.bold24
        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = TypographyFonts.regular16
        return label
    }()

    lazy var emailTextField: LoginTextField = {
        let textField = LoginTextField(placeholder: "mymail@gmail.com", title: "E-mail")
        return textField
    }()

    lazy var passwordTextField: LoginTextField = {
        let textField = LoginTextField(placeholder: "***********", title: "Password")
        return textField
    }()

    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 22
        button.setBackgroundColor(Assets.colorsYello.color, for: .normal)
        button.titleLabel?.font = TypographyFonts.regular16
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 8
        [topHeaderView].forEach { addSubview($0) }
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        [titleLabel, subtitleLabel, emailTextField, passwordTextField, continueButton].forEach { topHeaderView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        topHeaderView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(8)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(26)
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
        delegate?.methodSelected(in: self, method: .email)
    }
}
