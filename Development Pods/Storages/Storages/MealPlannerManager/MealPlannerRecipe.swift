//
//  MealPlannerRecipe.swift
//  Storages
//
//  Created by Akarys Turganbekuly on 15.01.2023.
//

import Foundation
import Models
import Extensions

public struct MealPlannerRecipe: Codable, Equatable {
    // MARK: - Proeprties

    public let recipeDate: Date
    public let recipeForDate: RecipeResponse

    // MARK: - Init
    
    public init(
        recipeDate: Date,
        recipeForDate: RecipeResponse
    ) {
        self.recipeDate = recipeDate
        self.recipeForDate = recipeForDate
    }

    // MARK: - Methods

    public func weekDay() -> MealPlannerWeekDays {
        return CalendarHelper().weekDayType(date: recipeDate)
    }

    public static func == (lhs: MealPlannerRecipe, rhs: MealPlannerRecipe) -> Bool {
        return lhs.recipeDate == rhs.recipeDate
    }
}
