//
//  RecipePageView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 03.02.2022.
//

import UIKit

public final class RecipePageView: UITableView {

    // MARK: - Initialization

    public init() {
        super.init(frame: .zero, style: .plain)

        configure()
    }

    public required init?(coder: NSCoder) {
        nil
    }

    // MARK: - Methods

    private func configure() {
        separatorStyle = .none
        tableFooterView = UIView(frame: .init(origin: .zero, size: CGSize(width: 0, height: 64)))

        [
            RecipeReviewsHeaderView.self
        ].forEach {
            register(aClass: $0)
        }

        [
            RecipeInformationViewCell.self,
            IngredientDescriptionCell.self,
            RecipeCaloriesViewCell.self,
            RecipeIngredientsViewCell.self,
            RecipeInstructionsViewCell.self,
            RecipeReviewsCell.self
        ].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
    }

}

