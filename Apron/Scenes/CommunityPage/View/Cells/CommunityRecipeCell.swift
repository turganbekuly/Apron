//
//  CommunityRecipeCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19.01.2022.
//

import UIKit
import DesignSystem

protocol ICommunityRecipeCell: AnyObject {
    func addToFavorite(_ cell: UITableViewCell, didTapAddButton button: UIButton)
    func userProfile(_ cell: UITableViewCell, didTapUserProfile button: UIButton)
}

final class CommunityRecipeCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: ICommunityRecipeCell?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    lazy var recipesCollectionView = RecipeCollectionView()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        contentView.addSubview(recipesCollectionView)
        setupConstraints()
    }

    private func setupConstraints() {
        recipesCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Methods

    func configure(with viewModel: ICommunityCollectionViewModel) {
        recipesCollectionView.delegate = viewModel.recipesDelegate
        recipesCollectionView.dataSource = viewModel.recipesDelegate
    }
}
