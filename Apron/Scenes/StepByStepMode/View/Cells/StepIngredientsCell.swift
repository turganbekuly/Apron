//
//  StepIngredientsCell.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 05.06.2023.
//

import UIKit
import APRUIKit
import SnapKit
import Storages
import Models

final class StepIngredientsCell: UICollectionViewCell {
    // MARK: - Properties

    private var ingredients: [RecipeIngredient] = []

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()

        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)

        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame

        return layoutAttributes
    }

    // MARK: - Views factory

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var recipeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = TypographyFonts.bold20
        label.numberOfLines = 0
        label.sizeToFit()
        label.text = "Подготовьте продукты"
        return label
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isScrollEnabled = true
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 55, right: 0)
        return scrollView
    }()

    private lazy var scrollContentView = UIView()

    // MARK: - Setup Views

    private func setupViews() {
        backgroundColor = .clear
        contentView.addSubviews(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubviews(
            recipeDescriptionLabel,
            stackView
        )
        makeContraints()
    }

    private func makeContraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        scrollContentView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.bottom.width.equalToSuperview()
        }
        
        recipeDescriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        stackView.snp.makeConstraints {
            $0.top.equalTo(recipeDescriptionLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        for view in stackView.arrangedSubviews {
            view.snp.makeConstraints {
                $0.width.equalToSuperview()
            }
        }
    }

    // MARK: - Methods

    func configure(with ingredients: [RecipeIngredient]) {
        self.ingredients = ingredients
        stackView.removeAllArrangedSubviews()
        ingredients.forEach {
            let view = IngredientView()
            view.configure(
                name: $0.product?.name ?? "",
                amount: $0.amount,
                unit: $0.measurement,
                image: $0.product?.image
            )
            stackView.addArrangedSubview(view)
        }
        stackView.layoutIfNeeded()
    }
}

