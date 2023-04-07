//
//  SavedRecipeCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import UIKit
import APRUIKit
import Kingfisher

protocol SavedRecipeCellProtocol: AnyObject {
    func navigateToRecipe(with id: Int)
}

final class SavedRecipeCell: UICollectionViewCell {
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var savedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.image = APRAssets.cmntImageview.image
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular16
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubviews(
            savedImageView,
            recipeNameLabel
        )
        setupConstraints()
    }

    private func setupConstraints() {
        savedImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(163)
        }

        recipeNameLabel.snp.makeConstraints {
            $0.top.equalTo(savedImageView.snp.bottom).offset(4)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }

    // MARK: - Method

    func configure(with viewModel: SavedRecipeCellViewModelProtocol) {
        savedImageView.kf.setImage(
            with: URL(string: viewModel.image ?? ""),
            placeholder: APRAssets.iconPlaceholderItem.image
        )
        recipeNameLabel.text = viewModel.name ?? ""
    }
}
