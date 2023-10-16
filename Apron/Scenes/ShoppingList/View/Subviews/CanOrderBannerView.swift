//
//  CanOrderBannerView.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 21.08.2023.
//

import UIKit
import APRUIKit

protocol CanOrderBannerViewProtocol: AnyObject {
    func closeOrderBanner()
    func showOnboarding()
}

final class CanOrderBannerView: View {
    // MARK: - Properties
    
    weak var delegate: CanOrderBannerViewProtocol?
    
    // MARK: - Views factory
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = APRAssets.primaryTextMain.color
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = TypographyFonts.bold18
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = TypographyFonts.regular16
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var showButton: NavigationButton = {
        let button = NavigationButton()
        button.backgroundType = .whiteBackground
        button.addTarget(self, action: #selector(showHowButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = APRAssets.iconNavigationCloseBackground.image
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    // MARK: - Setup views
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .clear
        addSubview(containerView)
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped))
        closeButton.addGestureRecognizer(tapGR)
        containerView.addSubviews(titleLabel, descriptionLabel, showButton, closeButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(8)
            $0.size.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.trailing.equalTo(closeButton.snp.leading).offset(-8)
            $0.leading.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        showButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(34)
        }
    }
    
    // MARK: - User actions
    
    @objc
    private func closeButtonTapped() {
        delegate?.closeOrderBanner()
    }
    
    @objc
    private func showHowButtonTapped() {
        delegate?.showOnboarding()
    }
    
    // MARK: - Public methods
    
    func configure(
        title: String,
        description: String,
        buttonTitle: String,
        shouldHideButton: Bool = false
    ) {
        titleLabel.text = title
        descriptionLabel.text = description
        showButton.setTitle(buttonTitle, for: .normal)
        
        if shouldHideButton {
            closeButton.isHidden = true
        }
    }
    
    func configure(backgroundColor: UIColor) {
        containerView.backgroundColor = backgroundColor
    }
}
