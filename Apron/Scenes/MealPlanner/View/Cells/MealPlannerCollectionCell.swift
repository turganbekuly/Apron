//
//  MealPlannerCollectionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.01.2023.
//

import APRUIKit
import UIKit
import Models
import Storages
import HapticTouch
import Extensions

protocol MealPlannerCollectionCellProtocol: AnyObject {
    func removeRecipe(with id: Int, with weekDay: MealPlannerWeekDays)
}

final class MealPlannerCollectionCell: UICollectionViewCell {
    // MARK: - Properties

    weak var delegate: MealPlannerCollectionCellProtocol?

    private var id = 0
    private var ingredients: [RecipeIngredient] = []

    var weekDay: MealPlannerWeekDays = .monday

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
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.layer.masksToBounds = false
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

    private lazy var removeRecipesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = APRAssets.iconNavigationCloseBackground.image
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
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(removeButtonTapped))
        removeRecipesImageView.addGestureRecognizer(tapGR)
        contentView.addSubview(containerView)
        containerView.addSubview(recipeImageView)
        recipeImageView.addSubviews(
            topOverlayView,
            bottomOverlayView
        )
        topOverlayView.addSubviews(
            removeRecipesImageView
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

        removeRecipesImageView.snp.makeConstraints {
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

    // MARK: - User actions

    @objc
    private func removeButtonTapped() {
        delegate?.removeRecipe(with: id, with: weekDay)
        HapticTouch.generateSuccess()
    }

    // MARK: - Public methods

    func configure(with recipe: RecipeResponse, with weekDay: MealPlannerDayNamingTypes) {
        switch weekDay {
        case .monday:
            self.weekDay = .monday
        case .tuesday:
            self.weekDay = .tuesday
        case .wednesday:
            self.weekDay = .wednesday
        case .thursday:
            self.weekDay = .thursday
        case .friday:
            self.weekDay = .friday
        case .saturday:
            self.weekDay = .saturday
        case .sunday:
            self.weekDay = .sunday
        }
        self.id = recipe.id
        self.recipeNameLabel.text = recipe.recipeName ?? ""
        self.recipeIngredientsCountLabel.text = "\(recipe.ingredients?.count ?? 0) ингредиентов"
        self.recipeImageView.kf.setImage(
            with: URL(string: recipe.imageURL ?? ""),
            placeholder: APRAssets.iconPlaceholderItem.image
        )
    }
}
