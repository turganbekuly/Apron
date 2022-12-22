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
    func saveRecipeTapped(with id: Int)
    func navigateToAuthFromRecipe()
    func navigateToRecipe(with id: Int)
    func cartItemsAdded()
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
    private var ingredients: [RecipeIngredient] = []
    private var recipeName = ""

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var recipeView: RecipeSearchResultTopView = {
        let view = RecipeSearchResultTopView()
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.clipsToBounds = true
        return view
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 15
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 3
        view.layer.shadowColor = ApronAssets.primaryTextMain.color.cgColor
        return view
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(ApronAssets.primaryTextMain.color, for: .normal)
        button.setImage(ApronAssets.favoriteIcon.image, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 14
        button.imageView?.contentMode = .scaleAspectFit
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
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 14
        imageView.tintColor = ApronAssets.gray.color
        return imageView
    }()

    private lazy var recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.medium16
        label.textColor = ApronAssets.primaryTextMain.color
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    let cartView = RecipeCartView()


    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubviews(
            recipeView,
            avatarOverlayView,
            recipeNameLabel,
            cartView
        )
        recipeView.addSubview(favoriteButton)
        avatarOverlayView.addSubview(avatarImageView)
        setupConstraints()
        configureCell()

        cartView.delegate = self
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
            $0.size.equalTo(28)
        }

        avatarOverlayView.snp.makeConstraints {
            $0.size.equalTo(38)
            $0.centerY.equalTo(recipeView.snp.bottom)
            $0.trailing.equalTo(recipeView.snp.trailing).offset(-8)
        }

        avatarImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalTo(28)
        }

        recipeNameLabel.snp.makeConstraints {
            $0.top.equalTo(avatarOverlayView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(8)
        }

        cartView.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.trailing.equalToSuperview().inset(8)
        }
    }

    private func configureCell() {
        backgroundColor = .clear
    }

    // MARK: - Private methods

    private func configureButton(isSaved: Bool) {
        guard isSaved else {
            favoriteButton.setImage(ApronAssets.favoriteIcon.image, for: .normal)
            return
        }

        favoriteButton.setImage(ApronAssets.favoriteFilledIcon.image, for: .normal)
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

        delegate?.saveRecipeTapped(with: id)
        HapticTouch.generateSuccess()
        favoriteButton.setImage(ApronAssets.favoriteFilledIcon.image, for: .normal)
    }

    // MARK: - Public methods

    func configure(with recipe: RecipeResponse) {
        recipeView.configure(
            with: RecipeSearchResultTopViewModel(
                recipeImage: recipe.imageURL,
                cookTime: "\(recipe.cookTime ?? 0) мин"
            )
        )
        isSaved = recipe.isSaved ?? false
        id = recipe.id
        avatarImageView.image = ApronAssets.user.image
        contentView.layoutIfNeeded()
        recipeNameLabel.text = recipe.recipeName
        cartView.configure(ingredients: recipe.ingredients?.count ?? 0)
        ingredients = recipe.ingredients ?? []
        recipeName = recipe.recipeName ?? ""
    }
}

extension RecipeSearchResultCell: RecipeCartViewDelegate {
    func cartViewTapped() {
        let cartItems: [CartItem] = self.ingredients.compactMap {
            CartItem(
                productId: $0.product?.id ?? 0,
                productName: $0.product?.name ?? "",
                productCategoryName: $0.product?.productCategoryName ?? "",
                productImage: $0.product?.image,
                amount: $0.amount ?? 0,
                measurement: $0.measurement ?? "",
                recipeName: [self.recipeName],
                bought: false
            )
        }
        cartItems.forEach {
            CartManager.shared.update(
                productId: $0.productId,
                productName: $0.productName,
                productCategoryName: $0.productCategoryName,
                productImage: $0.productImage,
                amount: $0.amount,
                measurement: $0.measurement,
                recipeName: $0.recipeName?.first ?? "",
                bought: $0.bought
            )
        }
        HapticTouch.generateSuccess()
        delegate?.cartItemsAdded()
    }
}
