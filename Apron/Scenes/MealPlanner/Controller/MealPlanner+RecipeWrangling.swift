//
//  MealPlanner+RecipeWrangling.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15.01.2023.
//

import Foundation
import Extensions
import Models

extension MealPlannerViewController: MealPlannerHeaderViewProtocol {
    func addButtonTapped(for weekDay: MealPlannerWeekDays?) {
        self.addingDay = weekDay
        let vc = SavedRecipesBuilder(state: .initial(.mealPlanner(self))).build()
        DispatchQueue.main.async {
            self.present(vc, animated: true)
        }
    }
}

extension MealPlannerViewController: SavedRecipeOutputModule {
    func savedRecipeSelected(recipe: RecipeResponse) {
        guard let day = addingDay else { return }
        let recipeDate = CalendarHelper().weekDayFromType(day, start: startDate, end: endDate)
        isLoadingButton(true)
        saveRecipe(recipeId: recipe.id, date: dateConverter(date: recipeDate))
    }
}

extension MealPlannerViewController: WeeklyCalendarViewProtocol {
    func weekDayRangeChanged(start: Date, end: Date) {
        self.startDate = start
        self.endDate = end
        sections = [
            .init(section: .monday(.monday), rows: [.monday(nil)]),
            .init(section: .tuesday(.tuesday), rows: [.tuesday(nil)]),
            .init(section: .wednesday(.wednesday), rows: [.wednesday(nil)]),
            .init(section: .thursday(.thursday), rows: [.thursday(nil)]),
            .init(section: .friday(.friday), rows: [.friday(nil)]),
            .init(section: .saturday(.saturday), rows: [.saturday(nil)]),
            .init(section: .sunday(.sunday), rows: [.sunday(nil)]),
        ]
        getRecipes(
            startDate: dateConverter(date: start),
            endDate: dateConverter(date: end)
        )
    }
}