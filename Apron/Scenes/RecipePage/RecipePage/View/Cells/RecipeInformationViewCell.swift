//
//  RecipeInformationViewCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24.01.2022.
//

import DesignSystem
import UIKit

final class RecipeInformationViewCell: UITableViewCell {
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold20
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setImage(Assets.recipeFavoriteIcon.image, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 19
        return button
    }()

    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.recipeLikeUnselected.image, for: .normal)
        button.setTitleColor(Assets.gray.color, for: .normal)
        button.setTitle("20", for: .normal)
        button.titleLabel?.font = TypographyFonts.regular16
        return button
    }()

    private lazy var dislikeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Assets.gray.color, for: .normal)
        button.setTitle("2", for: .normal)
        button.setImage(Assets.recipeDislikeUnselected.image, for: .normal)
        button.titleLabel?.font = TypographyFonts.regular16
        return button
    }()

    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.recipeEditIcon.image, for: .normal)
        return button
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(Assets.recipeShareIcon.image, for: .normal)
        return button
    }()

    private lazy var recipeSourceURLButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.black, for: .normal)
        button.titleLabel?.font = TypographyFonts.regular12
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        [
            titleLabel,
            subtitleLabel,
            recipeImageView,
            favoriteButton,
            likeButton,
            dislikeButton,
            editButton,
            shareButton
        ].forEach { addSubview($0) }

        [recipeSourceURLButton].forEach { recipeImageView.addSubview($0) }

        setupConstraints()
    }

    private func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(320)
        }
        
        favoriteButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(38)
            $0.width.equalTo(38)
        }

        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(favoriteButton.snp.centerY)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(favoriteButton.snp.leading).offset(-16)
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        recipeImageView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(205)
        }

        recipeSourceURLButton.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(11)
            $0.height.equalTo(20)
            $0.width.greaterThanOrEqualTo(120)
        }

        likeButton.snp.makeConstraints {
            $0.top.equalTo(recipeImageView.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(24)
        }

        dislikeButton.snp.makeConstraints {
            $0.top.equalTo(likeButton.snp.top)
            $0.leading.equalTo(likeButton.snp.trailing).offset(30)
            $0.height.equalTo(24)
        }

        shareButton.snp.makeConstraints {
            $0.top.equalTo(dislikeButton.snp.top)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }

        editButton.snp.makeConstraints {
            $0.top.equalTo(shareButton.snp.top)
            $0.trailing.equalTo(shareButton.snp.leading).offset(-16)
            $0.height.equalTo(24)
        }
    }

    // MARK: - Methods

    func configure(with viewModel: IRecipeInformationCellViewModel) {
        titleLabel.text = viewModel.recipeName
        subtitleLabel.text = viewModel.recipeSubtitle
        recipeSourceURLButton.setTitle(viewModel.recipeSourceURL, for: .normal)
        recipeSourceURLButton.sizeToFit()
        recipeImageView.image = Assets.recipeSampleImage.image
    }
}
