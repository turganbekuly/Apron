//
//  CommunityRecipeCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19.01.2022.
//

import DesignSystem
import UIKit
import SnapKit

final class CommunityRecipeCell: UITableViewCell {
    // MARK: - Properties

    private var faveButtonWidthConstraint: Constraint?

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular16
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()

    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setImage(Assets.recipeFavoriteIcon.image, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 19
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        return button
    }()

    private lazy var cookingTimeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.recipeCookingTimeIcon.image
        return imageView
    }()

    private lazy var cookingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
        label.textColor = Assets.gray.color
        return label
    }()

    private lazy var cookingInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cookingTimeImageView, cookingTimeLabel])
        stackView.axis = .horizontal
        stackView.spacing = 6
        return stackView
    }()

    private lazy var sourceURLLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.medium16
        label.textColor = .white
        return label
    }()

    private lazy var avaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
        label.textColor = .black
        return label
    }()

    private lazy var postingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = Assets.gray.color
        return label
    }()

    private lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            avaImageView,
            nameLabel,
            postingTimeLabel
        ])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none

        [
            recipeNameLabel,
            recipeImageView,
            favoriteButton,
            cookingInfoStackView,
            sourceURLLabel,
            userInfoStackView
        ].forEach { contentView.addSubview($0) }

        [favoriteButton, sourceURLLabel].forEach { recipeImageView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        recipeNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(snp.centerX)
        }

        cookingInfoStackView.snp.makeConstraints {
            $0.centerY.equalTo(recipeNameLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
        }

        recipeImageView.snp.makeConstraints {
            $0.top.equalTo(recipeNameLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo((bounds.width / 2))
        }

        sourceURLLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(14)
        }

        favoriteButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(38)
            faveButtonWidthConstraint = $0.width.equalTo(38).constraint
        }

        userInfoStackView.snp.makeConstraints {
            $0.top.equalTo(recipeImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Configure

    func configure(with viewModel: CommunityRecipesCellViewModelProtocol) {
        guard let recipe = viewModel.recipe else { return }
        self.recipeNameLabel.text = recipe.recipeName ?? ""
        self.cookingTimeLabel.text = recipe.cookTime ?? ""
        self.recipeImageView.kf.setImage(
            with: URL(string: recipe.imageURL ?? ""),
            placeholder: Assets.communityMockImage.image
        )
//        if viewModel.favCount != "0" {
//            self.favoriteButton.setTitle(viewModel.favCount, for: .normal)
//            faveButtonWidthConstraint?.update(offset: 70)
//        }
        self.sourceURLLabel.text = recipe.sourceLink ?? ""
//        if !viewModel.userImage.isEmpty {
        self.avaImageView.kf.setImage(with: URL(string: "viewModel.userImage"), placeholder: Assets.navAvatarIcon.image)
//        } else {
//            DispatchQueue.main.async {
//                self.avaImageView.setNameTitleImage(string: viewModel.userName)
//            }
//        }
        self.nameLabel.text = recipe.authorName ?? ""
        self.postingTimeLabel.text = recipe.createdAt ?? ""
    }
}
