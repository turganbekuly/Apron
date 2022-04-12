//
//  RecipeCreation+Sections.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.03.2022.
//

import Foundation
import Wormholy

extension RecipeCreationViewController {
    public struct Section {
        enum Section {
            case info
        }
        enum Row {
            case name
            case image
            case description
            case composition
            case instruction
            case servings
            case prepTime
            case cookTime
            case collection
        }
        let section: Section
        let rows: [Row]
    }

    public struct IngredientSection {
        enum Section {
            case ingredients
        }
        enum Row {
            case ingredient(RecipeCreationIngredientViewModel)
        }
        let section: Section
        let rows: [Row]
    }
}
