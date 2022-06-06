//
//  GeneralSearchShimmerView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15.05.2022.
//

import UIKit
import DesignSystem

final class GeneralSearchShimmerView: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var shimmerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.image = ApronAssets.iconPlaceholderItem.image
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var shimmerButton: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 17
        imageView.contentMode = .scaleAspectFill
        imageView.image = ApronAssets.iconPlaceholderCard.image
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private lazy var shimmerNameInfo: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.image = ApronAssets.iconPlaceholderCard.image
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var shimmerSubtitle: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.image = ApronAssets.iconPlaceholderCard.image
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [shimmerNameInfo, shimmerSubtitle])
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none

        [
            shimmerImageView,
            shimmerButton,
            stackView

        ].forEach {
            contentView.addSubview($0)
        }
        setupConstraints()
    }

    private func setupConstraints() {
        shimmerImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.size.equalTo(56)
        }

        shimmerButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(shimmerImageView.snp.centerY)
            $0.size.equalTo(38)
        }

        stackView.snp.makeConstraints {
            $0.centerY.equalTo(shimmerImageView.snp.centerY)
            $0.leading.equalTo(shimmerImageView.snp.trailing).offset(14)
            $0.trailing.equalTo(shimmerButton.snp.leading).offset(-14)
            $0.height.equalTo(56)
        }
    }

    // MARK: - Public methods

    func configure() {
    }
}
