//
//  RecipePage+Sections.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.01.2022.
//

import Foundation
import Wormholy

extension RecipePageViewController {
    struct Section {
        enum Section {
            case topView
            case description
            case ingredients
            case instructions
        }
        enum Row {
            case topView
            case description
            case ingredient
            case instruction

            static func == (lhs: Row, rhs: Row) -> Bool {
                switch(lhs, rhs) {
                case (.topView, .topView):
                    return true
                case (.description, .description):
                    return true
                case (.ingredient, .ingredient):
                    return true
                case (.instruction, .instruction):
                    return true
                default:
                    return false
                }
            }
        }

        let section: Section
        let rows: [Row]
    }
}
