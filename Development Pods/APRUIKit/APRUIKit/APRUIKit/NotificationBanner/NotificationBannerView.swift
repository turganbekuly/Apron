//
//  NotificationBannerView.swift
//  snoonu-ios
//
//  Created by Konstantin Yunevich on 10.12.2021.
//

import UIKit
import SnapKit

public enum NotificationBannerStyle {
    case success
    case information
}

final class NotificationBannerView: View {
    // MARK: - Public properties

    var style: NotificationBannerStyle = .success {
        didSet {
            setupStyle(style)
        }
    }

    var text: String? {
        didSet {
            textLabel.text = text
        }
    }

    // MARK: - UI Elements

    private lazy var containerView = UIView()
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    private lazy var iconImageView = UIImageView()

    // MARK: - UI Configuration

    override func setupViews() {
        super.setupViews()
        backgroundColor = .clear
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true

        textLabel.font = TypographyFonts.semibold14

        addSubviews(containerView)
        containerView.addSubviews(textLabel, iconImageView)

        setupStyle(.success)
    }

    override func setupConstraints() {
        super.setupConstraints()

        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(72)
        }

        textLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(18)
            $0.trailing.equalTo(iconImageView.snp.trailing).offset(-16)
        }

        iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-22)
            $0.size.equalTo(24)
        }
    }

    // MARK: - Private methods

    func setupStyle(_ style: NotificationBannerStyle) {
        switch style {
        case .success:
            let image = ApronAssets.iconTickGreen24.image.withRenderingMode(.alwaysTemplate)
            iconImageView.image = image
            iconImageView.tintColor = .white
            containerView.backgroundColor = ApronAssets.mainAppColor.color.withAlphaComponent(0.9)
            textLabel.textColor = .white
        case .information:
            iconImageView.isHidden = true
            containerView.backgroundColor = ApronAssets.primaryTextMain.color.withAlphaComponent(0.8)
            textLabel.textColor = .white
        }
    }
}
