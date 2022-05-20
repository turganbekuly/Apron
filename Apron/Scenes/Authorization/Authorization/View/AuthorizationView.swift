//
//  AuthorizationView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import DesignSystem

public protocol IAuthorizationView: AnyObject {
    func buttonPressed(type: AuthorizationType)
}

public enum AuthorizationType {
    case signin
    case signup
}

public final class AuthorizationView: UIView {
    // MARK: - Properties

    weak var delegate: IAuthorizationView?
    
    // MARK: - Initialization
    public init(delegate: IAuthorizationView?) {
        self.delegate = delegate

        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.loginBackgroundImage.image
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.isUserInteractionEnabled = true
        return view
    }()

    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.logoWhite.image
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Assets.colorsYello.color
        button.setTitle(L10n.Authorization.Button.SignUp.title, for: .normal)
        button.titleLabel?.font = TypographyFonts.regular20
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(sigupButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var signInButtonTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let firstAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: TypographyFonts.regular16]
        let secondAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: TypographyFonts.bold16]
        let firstString = NSMutableAttributedString(string: L10n.Authorization.Button.SignIn.disclaimer, attributes: firstAttributes)
        let secondString = NSAttributedString(string: L10n.Authorization.Button.SignIn.title, attributes: secondAttributes)
        firstString.append(secondString)
        label.attributedText = firstString
        label.isUserInteractionEnabled = true
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(overlayView)
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(siginButtonTapped))
        signInButtonTitle.addGestureRecognizer(tapGR)
        [logoImageView, signUpButton, signInButtonTitle].forEach { overlayView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-80)
            $0.width.equalTo(215)
            $0.height.equalTo(161)
        }

        signUpButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(signInButtonTitle.snp.top).offset(-24)
            $0.height.equalTo(56)
        }

        signInButtonTitle.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-56)
        }
    }

    // MARK: - User actions

    @objc
    private func siginButtonTapped() {
        delegate?.buttonPressed(type: .signin)
    }

    @objc
    private func sigupButtonTapped() {
        delegate?.buttonPressed(type: .signup)
    }
}
