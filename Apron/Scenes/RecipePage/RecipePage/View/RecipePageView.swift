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
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 160, right: 0)

        [
            RecipeReviewsHeaderView.self
        ].forEach {
            register(aClass: $0)
        }

        [
            RecipeReworkInfoViewCell.self,
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
