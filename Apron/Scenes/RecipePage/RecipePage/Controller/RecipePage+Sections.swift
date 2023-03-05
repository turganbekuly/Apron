//
//  RecipePage+Sections.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.01.2022.
//

import Foundation
import Wormholy
import Models

extension RecipePageViewController {
    struct Section {
        enum Section {
            case reworkInfo
            case topView
            case description
            case ingredients
            case nutritions
            case instructions
            case reviews
        }
        enum Row {
            case reworkInfo
            case topView
            case description
            case ingredient
            case nutrition
            case instruction
            case review(RecipeCommentResponse)

            static func == (lhs: Row, rhs: Row) -> Bool {
                switch(lhs, rhs) {
                case (.reworkInfo, .reworkInfo):
                    return true
                case (.topView, .topView):
                    return true
                case (.description, .description):
                    return true
                case (.ingredient, .ingredient):
                    return true
                case (.nutrition, .nutrition):
                    return true
                case (.instruction, .instruction):
                    return true
                case (.review, .review):
                    return true
                default:
                    return false
                }
            }
        }

        var section: Section
        var rows: [Row]
    }
}
