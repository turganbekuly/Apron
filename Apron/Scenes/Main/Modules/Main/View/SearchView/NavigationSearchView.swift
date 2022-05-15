//
//  NavigationSearchView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.01.2022.
//

import UIKit
import DesignSystem

final class NavigationSearchView: UIView {
    // MARK: - Init

    init(title: String? = "Поиск рецептов и сообществ", frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 17
        return view
    }()

    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.navSearchIcon.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = Assets.gray.color
        label.text = "Поиск рецептов и сообществ"
        return label
    }()

    // MARK: - Setup views

    private func setupViews() {
        backgroundColor = .clear
        addSubview(containerView)
        [iconView, titleLabel].forEach { containerView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
        }
        iconView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(7)
            $0.bottom.equalToSuperview().inset(7)
            $0.leading.equalToSuperview().offset(10)
            $0.width.equalTo(24)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(iconView.snp.centerY)
            $0.leading.equalTo(iconView.snp.trailing).offset(2)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}
