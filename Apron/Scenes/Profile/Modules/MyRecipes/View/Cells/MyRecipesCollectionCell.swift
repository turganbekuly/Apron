//
//  MyRecipesCollectionCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 26.01.2023.
//

import UIKit
import APRUIKit
import Models
import Storages
import HapticTouch

final class MyRecipesCollectionCell: UICollectionViewCell {
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

    private lazy var statusView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold12
        label.textColor = .white
        return label
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
        contentView.addSubview(containerView)
        containerView.addSubview(recipeImageView)
        recipeImageView.addSubviews(
            topOverlayView,
            bottomOverlayView
        )
        topOverlayView.addSubviews(
            statusView
        )

        statusView.addSubview(statusLabel)

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

        statusLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.bottom.top.equalToSuperview().inset(4)
        }

        statusView.snp.makeConstraints {
            $0.top.equalTo(topOverlayView.snp.top).offset(10)
            $0.trailing.equalTo(topOverlayView.snp.trailing).offset(-10)
            $0.height.equalTo(20)
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

    // MARK: - Public methods

    func configure(with recipe: RecipeResponse) {
        recipeNameLabel.text = recipe.recipeName ?? ""
        recipeIngredientsCountLabel.text = "\(recipe.ingredients?.count ?? 0) ингредиентов"
        statusLabel.text = recipe.status?.title?.uppercased() ?? ""
        switch recipe.status {
        case .active:
            statusView.backgroundColor = APRAssets.mainAppColor.color
        case .declined:
            statusView.backgroundColor = .red
        case .pending:
            statusView.backgroundColor = APRAssets.darkYello.color
        default:
            break
        }
        recipeImageView.kf.setImage(
            with: URL(string: recipe.imageURL ?? ""),
            placeholder: APRAssets.iconPlaceholderItem.image
        )
    }
}

