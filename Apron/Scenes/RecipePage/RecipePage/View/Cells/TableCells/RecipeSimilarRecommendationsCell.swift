//
//  RecipeSimilarRecommendationsCell.swift
//  Apron
//
//  Created by Акарыс Турганбекулы on 28.06.2023.
//

import UIKit
import APRUIKit
import SnapKit
import Models

protocol RecipeSimilarRecommendationDelegate: AnyObject {
    func recipeSelected(_ recipe: RecipeResponse, row point: CGFloat)
}

final class RecipeSimilarRecommendationsCell: UITableViewCell {
    // MARK: - Sections

    struct Section {
        enum Section {
            case recipes
        }
        enum Row {
            case recipe(RecipeResponse)
        }

        let section: Section
        let rows: [Row]
    }

    // MARK: - Properties

    let boldAttributes = [
        NSAttributedString.Key.font: TypographyFonts.semibold12,
        NSAttributedString.Key.foregroundColor: UIColor.black
    ]

    let regularAttributes = [
        NSAttributedString.Key.font: TypographyFonts.regular12,
        NSAttributedString.Key.foregroundColor: UIColor.black
    ]

    var commentImageViewHeight: Constraint?

    var recipesCollectionViewHeight: Constraint?

    var sections: [Section] = []
    
    weak var delegate: RecipeSimilarRecommendationDelegate?

    var recipes: [RecipeResponse]? {
        didSet {
            guard let recipes = recipes, !recipes.isEmpty else {
                sections = []
                recipesCollectionView.reloadData()
                return
            }
            sections = [.init(section: .recipes, rows: recipes.compactMap { .recipe($0) })]
            contentView.setNeedsLayout()
            contentView.layoutIfNeeded()
            recipesCollectionView.reloadData()
            recipesCollectionViewHeight?.update(offset: recipesCollectionView.collectionViewLayout.collectionViewContentSize.height)
        }
    }

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    private lazy var recommendationsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = TypographyFonts.semibold20
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    lazy var recipesCollectionView: RecipeSimilarRecommendationsCollectionView = {
        let collectionView = RecipeSimilarRecommendationsCollectionView()
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubviews(
            recommendationsTitleLabel,
            recipesCollectionView
        )
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        recommendationsTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.height.equalTo(30)
        }

        recipesCollectionView.snp.makeConstraints {
            $0.top.equalTo(recommendationsTitleLabel.snp.bottom).offset(16)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
    }

    private func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    // MARK: - Public methods

    func configure(with recipes: [RecipeResponse]?) {
        recommendationsTitleLabel.text = "Возможно вам понравится"
        self.recipes = recipes
    }
}

