//
//  NavigationBackButton.swift
//  APRUIKit
//
//  Created by Akarys Turganbekuly on 22.06.2022.
//

import UIKit

@available(iOS 13.0, *)
public final class NavigationBackButton: UIView {
    // MARK: - Public properties

    public var onBackButtonTapped: (() -> Void)?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold20
        label.textColor = APRAssets.primaryTextMain.color
        label.textAlignment = .left
        return label
    }()

    private lazy var backButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = APRAssets.navBackButton.image
            .withTintColor(APRAssets.primaryTextMain.color)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var leftButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton, titleLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
        leftButtonStackView.addGestureRecognizer(tapGR)
        addSubview(leftButtonStackView)
        setupConstraints()
    }

    private func setupConstraints() {
        leftButtonStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - User actions

    @objc
    private func backButtonTapped() {
        onBackButtonTapped?()
    }

    // MARK: - Methods

    public func configure(with title: String) {
        titleLabel.text = title
    }
}
