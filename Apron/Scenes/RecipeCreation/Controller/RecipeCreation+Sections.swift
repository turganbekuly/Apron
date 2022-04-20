//
//  RecipeCreation+Sections.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.03.2022.
//

import Foundation
import Models

extension RecipeCreationViewController {
    public struct Section {
        enum Section {
            case info
        }
        enum Row {
            case name
            case image
            case imagePlaceholder
            case description
            case composition
            case instruction
            case servings
            case prepTime
            case cookTime
            case collection
        }
        var section: Section
        var rows: [Row]
    }

    public struct IngredientSection {
        enum Section {
            case ingredients
        }
        enum Row {
            case ingredient
        }
        let section: Section
        let rows: [Row]
    }

    public struct InstructionSection {
        enum Section {
            case instructions
        }
        enum Row {
            case instruction
        }
        let section: Section
        let rows: [Row]
    }
}
