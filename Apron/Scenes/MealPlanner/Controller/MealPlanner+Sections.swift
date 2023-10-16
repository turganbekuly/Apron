//
//  MealPlanner+Sections.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15.01.2023.
//

import Foundation
import Models
import Extensions
import Storages

extension MealPlannerViewController {
    struct Section {
        enum Section: Equatable {
            case monday(MealPlannerWeekDays)
            case tuesday(MealPlannerWeekDays)
            case wednesday(MealPlannerWeekDays)
            case thursday(MealPlannerWeekDays)
            case friday(MealPlannerWeekDays)
            case saturday(MealPlannerWeekDays)
            case sunday(MealPlannerWeekDays)
            case onboarding
        }
        enum Row {
            case monday(MealPlannerResponse?)
            case tuesday(MealPlannerResponse?)
            case wednesday(MealPlannerResponse?)
            case thursday(MealPlannerResponse?)
            case friday(MealPlannerResponse?)
            case saturday(MealPlannerResponse?)
            case sunday(MealPlannerResponse?)
            case onboarding
        }

        let section: Section
        let rows: [Row]
    }
}
