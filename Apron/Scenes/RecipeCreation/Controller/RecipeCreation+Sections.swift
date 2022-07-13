//
//  RecipeCreation+Sections.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.03.2022.
//

import Foundation
import Models

extension RecipeCreationViewController {
    struct Section {
        enum Section {
            case info
        }
        enum Row {
            case name
            case source
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
}
