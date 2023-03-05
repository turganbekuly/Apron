//
//  MainCommunityEmptyCollectionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 26.05.2022.
//

import APRUIKit
import UIKit
import Kingfisher
import HapticTouch
import Storages

final class MainCommunityEmptyCollectionCell: UICollectionViewCell {
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.image = ApronAssets.iconPlaceholderItem.image
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var joinButton: UIImageView = {
        let button = UIImageView()
        button.layer.cornerRadius = 17
        button.clipsToBounds = true
        button.layer.masksToBounds = true
        button.image = ApronAssets.iconPlaceholderCard.image
        return button
    }()

    private lazy var communityNameLabel: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 17
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.image = ApronAssets.iconPlaceholderCard.image
        return image
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        [imageView, joinButton, communityNameLabel].forEach { contentView.addSubview($0) }
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(200)
        }

        joinButton.snp.makeConstraints {
            $0.bottom.equalTo(imageView.snp.bottom).offset(-11)
            $0.centerX.equalTo(imageView.snp.centerX)
            $0.height.equalTo(34)
            $0.width.equalTo(93)
        }

        communityNameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

    private func configureCell() {
        backgroundColor = .clear
    }
}
