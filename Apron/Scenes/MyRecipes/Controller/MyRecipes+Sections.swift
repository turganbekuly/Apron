//
//  MyRecipes+Sections.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22.01.2023.
//

import Foundation
import Models

extension MyRecipesViewController {
    struct Section {
        enum Section {
            case recipes
        }
        enum Row {
            case shimmer
            case empty
            case recipe(RecipeResponse)
        }

        let section: Section
        let rows: [Row]
    }
}
