//
//  EmptyListCollectionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 18.07.2022.
//

import UIKit
import APRUIKit

final class EmptyListCollectionCell: UICollectionViewCell {
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var emptyTextLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    private lazy var emptyStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        contentView.addSubviews(
            emptyTextLabel,
            emptyStateImageView
        )
        
        setupConstraints()
    }

    private func setupConstraints() {
        emptyTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36)
            $0.leading.trailing.equalToSuperview().inset(76)
        }

        emptyStateImageView.snp.makeConstraints {
            $0.top.equalTo(emptyTextLabel.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 223, height: 205))
        }
    }

    // MARK: - Methods

    func configure(with title: String, image: UIImage) {
        self.emptyTextLabel.text = title
        self.emptyStateImageView.image = image
    }
}

