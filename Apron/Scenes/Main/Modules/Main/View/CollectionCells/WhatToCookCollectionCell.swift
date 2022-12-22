//
//  WhatToCookCollectionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17.10.2022.
//

import UIKit
import APRUIKit

final class WhatToCookCollectionCell: UICollectionViewCell {
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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular16
        label.textColor = ApronAssets.primaryTextMain.color
        label.textAlignment = .center
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubview(imageView)
        imageView.addSubview(nameLabel)
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
    }

    private func configureCell() {
        backgroundColor = .clear
    }

    // MARK: - Methods

    func configure(with type: WhatToCookCategoryTypes) {
        imageView.image = type.image
        nameLabel.text = type.title
    }
}

