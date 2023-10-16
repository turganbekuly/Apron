//
//  MealPlannerCell.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15.01.2023.
//

import UIKit
import APRUIKit
import Models
import Storages
import Extensions

protocol MealPlannerCellProtocol: AnyObject {
    func removeRecipe(with id: Int, with weekDay: MealPlannerWeekDays)
    func openRecipe(with id: Int)
}

final class MealPlannerCell: UITableViewCell {
    // MARK: - Sections

    struct RecipesSection {
        enum Section {
            case recipes
        }

        enum Row {
            case recipe(RecipeResponse, MealPlannerDayNamingTypes)
            case shimmer
        }

        let section: Section
        let rows: [Row]
    }

    // MARK: - Properties

    var recipesSections: [RecipesSection] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    weak var delegate: MealPlannerCellProtocol?
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views factory

    lazy var collectionView = MealPlannerCollectionView()

    // MARK: - Setup Views

    private func setupViews() {
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        setupConstraints()
        configureCell()
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func configureCell() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    // MARK: - Methods

    func configure(mealPlanner: MealPlannerResponse?) {
        guard
            let mealPlanner = mealPlanner,
            let weekDay = mealPlanner.day,
            let recipes = mealPlanner.recipes
        else {
            recipesSections = [.init(section: .recipes, rows: Array(repeating: .shimmer, count: 3))]
            return
        }
        recipesSections = [.init(section: .recipes, rows: recipes.compactMap { .recipe($0, weekDay) })]
    }
}
