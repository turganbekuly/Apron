//
//  RecipeCreationView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

final class RecipeCreationView: UICollectionView {
    
    // MARK: - Init
    public init() {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 8
            layout.scrollDirection = .vertical
            return layout
        }()

        super.init(frame: .zero, collectionViewLayout: layout)

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
        allowsMultipleSelection = false
        keyboardDismissMode = .onDrag
        showsHorizontalScrollIndicator = false
        isScrollEnabled = true

        [
            RecipeCreationNamingCell.self,
            RecipeCreationImageCell.self,
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
    }

}
