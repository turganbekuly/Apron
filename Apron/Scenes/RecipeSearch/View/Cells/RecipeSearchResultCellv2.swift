//
//  RecipeSearchResultCellv2.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11.12.2022.
//

import UIKit
import APRUIKit
import Models
import Storages
import HapticTouch

protocol RecipeSearchCellV2Protocol: AnyObject {
    func saveRecipeTappedv2(with id: Int)
    func navigateToAuthFromRecipev2()
    func navigateToRecipev2(with id: Int)
}

final class RecipeSearchResultCellv2: UICollectionViewCell {
    // MARK: - Properties

    weak var delegate: RecipeSearchCellV2Protocol?
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

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 20
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 3
        view.layer.shadowColor = ApronAssets.primaryTextMain.color.cgColor
        return view
    }()

    private lazy var recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private lazy var favoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = ApronAssets.favoriteIcon24.image
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private lazy var topOverlayView: GradientView = {
        let view = GradientView()
        view.isUserInteractionEnabled = true
        view.topColor = ApronAssets.primaryTextMain.color.withAlphaComponent(0.7)
        view.bottomColor = ApronAssets.primaryTextMain.color.withAlphaComponent(0.01)
        view.startPointX = 0.5
        view.endPointX = 0.5
        view.startPointY = 0
        view.endPointY = 1
        return view
    }()

    private lazy var bottomOverlayView: GradientView = {
        let view = GradientView()
        view.isUserInteractionEnabled = true
        view.topColor = ApronAssets.primaryTextMain.color.withAlphaComponent(0.01)
        view.bottomColor = ApronAssets.primaryTextMain.color.withAlphaComponent(0.7)
        view.startPointX = 0.5
        view.endPointX = 0.5
        view.startPointY = 0
        view.endPointY = 1
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

    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.medium14
        label.textColor = .white
        return label
    }()

    private lazy var ratingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = ApronAssets.recipeLikeSelected.image.withTintColor(.white)
        return imageView
    }()

    private lazy var recipeNameLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.medium14
        label.textColor = .white
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var recipeIngredientsCountLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.medium12
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()


    // MARK: - Setup Views

    private func setupViews() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(saveButtonTapped))
        favoriteImageView.addGestureRecognizer(tapGR)
        contentView.addSubview(containerView)
        containerView.addSubview(recipeImageView)
        recipeImageView.addSubviews(
            topOverlayView,
            bottomOverlayView
        )
        topOverlayView.addSubviews(
            favoriteImageView,
            ratingImageView,
            ratingLabel
        )

        bottomOverlayView.addSubviews(
            recipeNameLabel,
            recipeIngredientsCountLabel
        )
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        containerView.snp.matchSuperview()
        recipeImageView.snp.matchSuperview()
        topOverlayView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }

        bottomOverlayView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }

        ratingImageView.snp.makeConstraints {
            $0.top.equalTo(topOverlayView.snp.top).offset(10)
            $0.leading.equalTo(topOverlayView.snp.leading).offset(10)
            $0.size.equalTo(28)
        }

        ratingLabel.snp.makeConstraints {
            $0.centerY.equalTo(ratingImageView.snp.centerY)
            $0.leading.equalTo(ratingImageView.snp.trailing).offset(2)
        }

        favoriteImageView.snp.makeConstraints {
            $0.top.equalTo(topOverlayView.snp.top).offset(10)
            $0.trailing.equalTo(topOverlayView.snp.trailing).offset(-10)
            $0.size.equalTo(24)
        }

        recipeNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(recipeIngredientsCountLabel.snp.top).offset(-4)
            $0.leading.equalTo(bottomOverlayView.snp.leading).offset(10)
            $0.trailing.equalTo(bottomOverlayView.snp.trailing).offset(-10)
        }

        recipeIngredientsCountLabel.snp.makeConstraints {
            $0.bottom.equalTo(bottomOverlayView.snp.bottom).offset(-10)
            $0.leading.equalTo(bottomOverlayView.snp.leading).offset(10)
            $0.trailing.equalTo(bottomOverlayView.snp.trailing).offset(-10)
        }
    }

    private func configureCell() {
        backgroundColor = .clear
    }

    // MARK: - Private methods

    private func configureButton(isSaved: Bool) {
        guard isSaved else {
            favoriteImageView.image = ApronAssets.favoriteIcon.image
            return
        }

        favoriteImageView.image = ApronAssets.favoriteFilledIcon.image
    }

    // MARK: - User actions

    @objc
    private func saveButtonTapped() {
        guard AuthStorage.shared.isUserAuthorized else {
            delegate?.navigateToAuthFromRecipev2()
            return
        }

        guard !isSaved else {
            delegate?.navigateToRecipev2(with: id)
            return
        }

        delegate?.saveRecipeTappedv2(with: id)
        HapticTouch.generateSuccess()
        favoriteImageView.image = ApronAssets.favoriteFilledIcon.image
    }

    // MARK: - Public methods

    func configure(with recipe: RecipeResponse) {
        isSaved = recipe.isSaved ?? false
        id = recipe.id
        recipeNameLabel.text = recipe.recipeName ?? ""
        recipeIngredientsCountLabel.text = "\(recipe.ingredients?.count ?? 0) ингредиентов"
        recipeImageView.kf.setImage(
            with: URL(string: recipe.imageURL ?? ""),
            placeholder: ApronAssets.iconPlaceholderItem.image
        )
        let likesCount = recipe.likesCount ?? 0
        let dislikesCount = recipe.dislikesCount ?? 0
        if likesCount > 0 && dislikesCount >= 0 {
            let percentRatio = ((likesCount / (likesCount + dislikesCount)) * 100)
            ratingLabel.text = "\(percentRatio)"
            recipeImageView.image = ApronAssets.recipeLikeSelected.image.withTintColor(.white)
            ratingImageView.isHidden = false
        } else if dislikesCount > 0 && likesCount == 0 {
            let percentRatio = ((dislikesCount / (likesCount + dislikesCount)) * 100)
            ratingLabel.text = "\(percentRatio)"
            ratingImageView.isHidden = false
            ratingImageView.image = ApronAssets.recipeDislikeSelected.image.withTintColor(.white)
        } else if likesCount < 0 && dislikesCount < 0 {
            ratingLabel.text = ""
            ratingImageView.isHidden = true
        }
    }
}
