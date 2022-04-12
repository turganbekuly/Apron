//
//  RecipeCreationImageCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 06.04.2022.
//

import UIKit
import DesignSystem

final class RecipeCreationImageCell: UICollectionViewCell {
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var imagePlaceholder = PhotoPlaceholderView()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubview(imagePlaceholder)
        setupConstraints()
    }

    private func setupConstraints() {
        imagePlaceholder.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: - Public methods

    func configure() { }
}
