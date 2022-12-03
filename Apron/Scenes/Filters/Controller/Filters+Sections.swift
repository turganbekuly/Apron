//
//  Filters+Sections.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09.10.2022.
//

import Foundation
import Models

extension FiltersViewController {
    struct Section {
        enum Section {
            case cookingTime
            case dayTimeType
            case cuisines
            case dishTypes
            case ingredients
            case eventTypes
            case lifestyleTypes
            case addIngredient
            case addCuisine
        }
        enum Row {
            case cookingTime(SuggestedCookingTimeType)
            case dayTimeType(SuggestedDayTimeType)
            case cuisine(RecipeCuisine)
            case dishType(SuggestedDishType)
            case ingredient(RecipeIngredient)
            case eventType(SuggestedEventType)
            case lifestyleType(SuggestedLifestyleType)
            case addIngredient
            case addCuisine
        }

        let section: Section
        let rows: [Row]
    }
}
