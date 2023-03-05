//
//  MealPlanner+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models

extension MealPlannerViewController {

    // MARK: - Network

    func getRecipes(startDate: String, endDate: String) {
        interactor.getMealPlannerRecipes(request: .init(startDate: startDate, endDate: endDate))
    }

    func saveRecipe(recipeId: Int, date: String) {
        interactor.saveMealPlannerRecipe(request: .init(body: MealPlannerRequestBody(recipeId: recipeId, date: date)))
    }

    func removeRecipe(recipeId: Int, date: String) {
        interactor.removeMealPlannerRecipe(request: .init(body: MealPlannerRequestBody(recipeId: recipeId, date: date)))
    }
}
