//
//  MealPlanner+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import UIKit

extension MealPlannerViewController: MealPlannerDisplayLogic {
    // MARK: - MealPlannerDisplayLogic

    func displayGetMealPlannerRecipes(viewModel: MealPlannerDataFlow.GetMealPlannerRecipes.ViewModel) {
        state = viewModel.state
    }

    func displaySaveMealPlannerRecipe(viewModel: MealPlannerDataFlow.MealPlannerRecipeOperation.ViewModel) {
        state = viewModel.state
    }

    func displayRemoveMealPlannerRecipe(viewModel: MealPlannerDataFlow.MealPlannerRecipeOperation.ViewModel) {
        state = viewModel.state
    }
}
