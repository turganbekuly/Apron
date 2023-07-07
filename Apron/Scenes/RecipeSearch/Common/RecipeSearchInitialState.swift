//
//  RecipeSearchInitialState.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 12.12.2022.
//

import Foundation
import Models

protocol MealPlannerRecipeSelected: AnyObject {
    func mealPlanner(selected recipe: RecipeResponse)
}

enum RecipeSearchInitialState {
    case generalSearch(SearchFilterRequestBody)
    case mealPlannerSearch(SearchFilterRequestBody, MealPlannerRecipeSelected)
}
