//
//  CommunityRecipeCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19.01.2022.
//

import APRUIKit
import UIKit
import SnapKit
import Storages
import HapticTouch

protocol CommunityRecipeCellProtocol: AnyObject {
    func didTapSaveRecipe(with id: Int)
    func navigateToAuthFromRecipe()
    func navigateToRecipe(with id: Int)
}

final class CommunityRecipeCell: UITableViewCell {
    // MARK: - Properties

    weak var delegate: CommunityRecipeCellProtocol?
    private var faveButtonWidthConstraint: Constraint?
    private var isSaved: Bool = false {
        didSet {
            configureButton(isSaved: isSaved)
        }
    }
    private var id = 0

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
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.black, for: .normal)
        button.setImage(APRAssets.recipeFavoriteIcon.image, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 19
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var cookingTimeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = APRAssets.recipeCookingTimeIcon.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var cookingTimeLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular14
        label.textColor = APRAssets.gray.color
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
        imageView.layer.cornerRadius = 8
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
        label.textColor = APRAssets.gray.color
        return label
    }()

    private lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView()
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
            cookingInfoStackView,
            sourceURLLabel,
            userInfoStackView
        ].forEach { contentView.addSubview($0) }

        [favoriteButton, sourceURLLabel].forEach { recipeImageView.addSubview($0) }
        setupConstraints()
    }

    private func setupConstraints() {
        avaImageView.snp.makeConstraints {
            $0.size.equalTo(16)
        }

        recipeNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(cookingInfoStackView.snp.leading).offset(-4)
        }

        cookingInfoStackView.snp.makeConstraints {
            $0.centerY.equalTo(recipeNameLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.lessThanOrEqualTo(100)
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

    // MARK: - Private methods

    private func configureButton(isSaved: Bool) {
        guard isSaved else {
            favoriteButton.setBackgroundColor(.black, for: .normal)
            favoriteButton.setImage(APRAssets.recipeFavoriteIcon.image, for: .normal)
            return
        }

        favoriteButton.setBackgroundColor(APRAssets.colorsYello.color, for: .normal)
        favoriteButton.setImage(APRAssets.tabFaveSelectedIcon.image, for: .normal)
    }

    // MARK: - User actions

    @objc
    private func saveButtonTapped() {
        guard AuthStorage.shared.isUserAuthorized else {
            delegate?.navigateToAuthFromRecipe()
            return
        }

        guard !isSaved else {
            delegate?.navigateToRecipe(with: id)
            return
        }

        HapticTouch.generateSuccess()
        favoriteButton.setBackgroundColor(APRAssets.colorsYello.color, for: .normal)
        favoriteButton.setImage(APRAssets.tabFaveSelectedIcon.image, for: .normal)
        delegate?.didTapSaveRecipe(with: id)
    }

    // MARK: - Configure

    func configure(with viewModel: CommunityRecipesCellViewModelProtocol) {
        guard let recipe = viewModel.recipe else { return }
        self.recipeNameLabel.text = recipe.recipeName ?? ""
        self.cookingTimeLabel.text = "\(recipe.cookTime ?? 0)"
        self.recipeImageView.kf.setImage(
            with: URL(string: recipe.imageURL ?? ""),
            placeholder: APRAssets.iconPlaceholderCard.image
        )
        self.id = recipe.id
        self.sourceURLLabel.text = recipe.sourceLink ?? ""
        self.isSaved = recipe.isSaved ?? false

        userInfoStackView.removeAllArrangedSubviews()
//        self.avaImageView.setImage(string: recipe.authorName ?? "User")
//        self.avaImageView.setNameTitleImage(
//            string: recipe.authorName ?? "User",
//            color: .random,
//            circular: true,
//            stroke: false,
//            textAttributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
//                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)]
//        )
        self.postingTimeLabel.text = recipe.createdAt ?? ""
        self.nameLabel.text = recipe.authorName?.username ?? ""
        userInfoStackView.addArrangedSubviews(
            avaImageView,
            nameLabel,
            postingTimeLabel
        )
        userInfoStackView.layoutIfNeeded()
//        if viewModel.recipe?.savedUserCount != 0 {
//            self.favoriteButton.setTitle("\(recipe.savedUserCount ?? 1)", for: .normal)
//            faveButtonWidthConstraint?.update(offset: 70)
//        }
//        if !viewModel.userImage.isEmpty {
//        self.avaImageView.kf.setImage(with: URL(string: "viewModel.userImage"), placeholder: Assets.navAvatarIcon.image)
//        } else {
//            DispatchQueue.main.async {
//                self.avaImageView.setNameTitleImage(string: viewModel.userName)
//            }
//        }
    }
}
