//
//  RecipePage+Sections.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.01.2022.
//

import Foundation
import Wormholy

extension RecipePageViewController {
    public struct Section {
        enum Section {
            case topView
            case ingredients
//            case calories
//            case instructions
        }
        enum Row {
            case topView(RecipeInformationCellViewModel)
            case ingredient(IngredientsListCellViewModel)
//            case calorie
//            case instruction
        }

        let section: Section
        let rows: [Row]
    }
}
