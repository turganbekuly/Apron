//
//  RecipeSearchSuggestionsCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.10.2022.
//

import UIKit
import APRUIKit

final class RecipeSearchSuggestionsCell: UICollectionViewCell {
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = ApronAssets.iconChartUp.image
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular16
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()

    private lazy var separatorView = SeparatorView()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubviews(
            iconImageView,
            titleLabel,
            separatorView
        )
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        separatorView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.size.equalTo(24)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(iconImageView.snp.centerY)
            $0.leading.equalTo(iconImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(8)
        }
    }

    private func configureCell() {
        backgroundColor = .clear
    }

    // MARK: - Public methods

    func configure(title: String) {
        titleLabel.text = title
    }
}
