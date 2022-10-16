//
//  RecipeSearchResultCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.10.2022.
//

import UIKit
import APRUIKit
import Storages
import HapticTouch
import SnapKit
import Models

protocol RecipeSearchCellProtocol: AnyObject {
    func didTapSaveRecipe(with id: Int)
    func navigateToAuthFromRecipe()
    func navigateToRecipe(with id: Int)
}

final class RecipeSearchResultCell: UICollectionViewCell {
    // MARK: - Properties

    weak var delegate: RecipeSearchCellProtocol?
    private var isSaved: Bool = false {
        didSet {
            configureButton(isSaved: isSaved)
        }
    }
    private var id = 0

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var recipeView = RecipeSearchResultTopView()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 8)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        return view
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.black, for: .normal)
        button.setImage(ApronAssets.recipeFavoriteIcon.image, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var avatarOverlayView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 18
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 8)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 16
        view.layer.shadowColor = UIColor(red: 0.573, green: 0.573, blue: 0.573, alpha: 0.15).cgColor
        return view
    }()

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.medium16
        label.textColor = .black
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var ingredientsCountLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.regular12
        label.textColor = ApronAssets.gray.color
        return label
    }()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubviews(
            recipeView,
            avatarOverlayView,
            recipeNameLabel,
            ingredientsCountLabel
        )
        recipeView.addSubview(favoriteButton)
        avatarOverlayView.addSubview(avatarImageView)
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        recipeView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(163)
        }

        favoriteButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(8)
            $0.size.equalTo(24)
        }

        avatarOverlayView.snp.makeConstraints {
            $0.size.equalTo(38)
            $0.centerY.equalTo(recipeView.snp.bottom)
            $0.trailing.equalTo(recipeView.snp.trailing).offset(-8)
        }

        avatarImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }

        recipeNameLabel.snp.makeConstraints {
            $0.top.equalTo(avatarOverlayView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(8)
        }

        ingredientsCountLabel.snp.makeConstraints {
            $0.bottom.trailing.leading.equalToSuperview().inset(8)
        }
    }

    private func configureCell() {
        backgroundColor = .clear
    }

    // MARK: - Private methods

    private func configureButton(isSaved: Bool) {
        guard isSaved else {
            favoriteButton.setBackgroundColor(.black, for: .normal)
            favoriteButton.setImage(ApronAssets.recipeFavoriteIcon.image, for: .normal)
            return
        }

        favoriteButton.setBackgroundColor(ApronAssets.colorsYello.color, for: .normal)
        favoriteButton.setImage(ApronAssets.tabFaveSelectedIcon.image, for: .normal)
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
        favoriteButton.setBackgroundColor(ApronAssets.colorsYello.color, for: .normal)
        favoriteButton.setImage(ApronAssets.tabFaveSelectedIcon.image, for: .normal)
        delegate?.didTapSaveRecipe(with: id)
    }

    // MARK: - Public methods

    func configure(with recipe: RecipeResponse) {
        recipeView.configure(
            with: RecipeSearchResultTopViewModel(
                recipeImage: recipe.imageURL,
                cookTime: "\(recipe.cookTime ?? 0) мин"
            )
        )

        avatarImageView.setNameTitleImage(
            string: recipe.authorName ?? "User",
            color: .random,
            circular: true,
            stroke: false,
            textAttributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11)
            ]
        )
        contentView.layoutIfNeeded()
        recipeNameLabel.text = recipe.recipeName
        ingredientsCountLabel.text = "\(recipe.ingredients?.count ?? 0) ингредиентов"
    }
}
