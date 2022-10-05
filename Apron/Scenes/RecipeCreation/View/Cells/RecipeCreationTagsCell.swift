//
//  RecipeCreationTagsCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21.08.2022.
//

import UIKit
import APRUIKit

final class RecipeCreationTagsCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    lazy var collectionView = AddCommentCollectionView()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubview(collectionView)
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    private func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    // MARK: - Public methods

    func configure() {
        collectionView.reloadData()
    }
}

