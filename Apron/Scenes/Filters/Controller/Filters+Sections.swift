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
        enum Row: Equatable {
            case cookingTime(SuggestedCookingTimeType)
            case dayTimeType(SuggestedDayTimeType)
            case cuisine(RecipeCuisine)
            case dishType(SuggestedDishType)
            case ingredient(Product)
            case eventType(SuggestedEventType)
            case lifestyleType(SuggestedLifestyleType)
            case addIngredient
            case addCuisine

            static func == (lhs: Row, rhs: Row) -> Bool {
                switch (lhs, rhs) {
                case (.cookingTime, .cookingTime):
                    return true
                case (.dayTimeType, .dayTimeType):
                    return true
                case (.cuisine, .cuisine):
                    return true
                case (.dishType, .dishType):
                    return true
                case (.ingredient, .ingredient):
                    return true
                case (.eventType, .eventType):
                    return true
                case (.lifestyleType, .lifestyleType):
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
