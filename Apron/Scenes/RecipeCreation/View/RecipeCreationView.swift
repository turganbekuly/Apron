//
//  RecipeCreationView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

final class RecipeCreationView: UITableView {
    
    // MARK: - Init
    init() {
        super.init(frame: .zero, style: .plain)

        configure()
    }

    public required init?(coder: NSCoder) {
        return nil
    }

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        configureColors()
    }

    // MARK: - Methods
    private func configure() {
        separatorStyle = .none
        keyboardDismissMode = .onDrag
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)

        [
            RecipeCreationNamingCell.self,
            RecipeCreationSourceURLCell.self,
            RecipeCreationImageCell.self,
            RecipeCreationPlaceholderImageCell.self,
            RecipeCreationDescriptionCell.self,
            RecipeCreationAddIngredientCell.self,
            RecipeCreationAddInstructionCell.self,
            RecipeCreationAssignCell.self
        ].forEach {
            register(cellClass: $0)
        }
        configureColors()
    }

    private func configureColors() {
        backgroundColor = .clear
        separatorStyle = .none
    }

}
