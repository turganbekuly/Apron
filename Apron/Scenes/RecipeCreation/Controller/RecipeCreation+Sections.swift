//
//  RecipeCreation+Sections.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.03.2022.
//

import Foundation

extension RecipeCreationViewController {
    public struct Section {
        enum Section {
            case name
            case source
            case image
            case description
            case composition
            case instructions
            case servings
            case prepTime
            case cookTime
            case collections
        }
        enum Row {
            case name
            case source
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
}
