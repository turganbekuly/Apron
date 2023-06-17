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
        view.layer.shadowColor = APRAssets.primaryTextMain.color.cgColor
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
        imageView.image = APRAssets.heart24White.image
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private lazy var topOverlayView: GradientView = {
        let view = GradientView()
        view.isUserInteractionEnabled = true
        view.topColor = APRAssets.primaryTextMain.color.withAlphaComponent(0.7)
        view.bottomColor = APRAssets.primaryTextMain.color.withAlphaComponent(0.01)
        view.startPointX = 0.5
        view.endPointX = 0.5
        view.startPointY = 0
        view.endPointY = 1
        return view
    }()

    private lazy var bottomOverlayView: GradientView = {
        let view = GradientView()
        view.isUserInteractionEnabled = true
        view.topColor = APRAssets.primaryTextMain.color.withAlphaComponent(0.01)
        view.bottomColor = APRAssets.primaryTextMain.color.withAlphaComponent(0.7)
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
        imageView.tintColor = APRAssets.gray.color
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
        imageView.image = APRAssets.recipeLikeSelected.image.withTintColor(.white)
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)

        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: [.beginFromCurrentState],
            animations: {
                self.containerView.transform = self.containerView.transform.scaledBy(
                    x: 0.9,
                    y: 0.9
                )
            }
        )
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        touchesEnded(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        UIView.animate(
            withDuration: 0.1,
            delay: 0.07,
            options: [.beginFromCurrentState],
            animations: {
                self.containerView.transform = .identity
            }
        )
    }

    // MARK: - Private methods

    private func configureButton(isSaved: Bool) {
        guard isSaved else {
            favoriteImageView.image = APRAssets.heart24White.image
            return
        }

        favoriteImageView.image = APRAssets.heartFilled24White.image
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
        favoriteImageView.image = APRAssets.heartFilled24White.image
    }

    // MARK: - Public methods

    func configure(with recipe: RecipeResponse) {
        isSaved = recipe.isSaved ?? false
        id = recipe.id
        recipeNameLabel.text = recipe.recipeName ?? ""
        recipeIngredientsCountLabel.text = "\(recipe.ingredients?.count ?? 0) ингредиентов"
        recipeImageView.kf.setImage(
            with: URL(string: recipe.imageURL ?? ""),
            placeholder: APRAssets.iconPlaceholderItem.image,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(0.4)),
                .cacheOriginalImage
            ]
        )
        let likesCount = recipe.likesCount ?? 0
        let dislikesCount = recipe.dislikesCount ?? 0
        if likesCount > 0 && dislikesCount >= 0 {
            let percentRatio = ((likesCount / (likesCount + dislikesCount)) * 100)
            ratingLabel.text = "\(percentRatio) %"
            ratingImageView.image = APRAssets.recipeLikeSelected.image.withTintColor(.white)
            ratingImageView.isHidden = false
        } else if dislikesCount > 0 && likesCount == 0 {
            let percentRatio = ((dislikesCount / (likesCount + dislikesCount)) * 100)
            ratingLabel.text = "\(percentRatio) %"
            ratingImageView.isHidden = false
            ratingImageView.image = APRAssets.recipeDislikeSelected.image.withTintColor(.white)
        } else if likesCount <= 0 && dislikesCount <= 0 {
            ratingLabel.text = ""
            ratingImageView.isHidden = true
        }
    }
}
