//
//  RecipeCreationPlaceholderImageCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 12.04.2022.
//

import UIKit
import DesignSystem

final class RecipeCreationPlaceholderImageCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
            $0.bottom.leading.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: - Public methods

    func configure() {

    }
}