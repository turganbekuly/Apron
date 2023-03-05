//
//  MealPlannerPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import UIKit

protocol MealPlannerPresentationLogic: AnyObject {
    func getMealPlannerRecipes(
        response: MealPlannerDataFlow.GetMealPlannerRecipes.Response
    )
    func saveMealPlannerRecipe(
        response: MealPlannerDataFlow.MealPlannerRecipeOperation.Response
    )
    func removeMealPlannerRecipe(
        response: MealPlannerDataFlow.MealPlannerRecipeOperation.Response
    )
}

final class MealPlannerPresenter: MealPlannerPresentationLogic {



    // MARK: - Properties
    weak var viewController: MealPlannerDisplayLogic?

    // MARK: - MealPlannerPresentationLogic

    func getMealPlannerRecipes(response: MealPlannerDataFlow.GetMealPlannerRecipes.Response) {
        var viewModel: MealPlannerDataFlow.GetMealPlannerRecipes.ViewModel

        defer { self.viewController?.displayGetMealPlannerRecipes(viewModel: viewModel) }

        switch response.result {
        case let .success(model):
            viewModel = .init(state: .getRecipesSucceed(model))
        case let .error(error):
            viewModel = .init(state: .getRecipesFailed(error))
        }
    }

    func saveMealPlannerRecipe(response: MealPlannerDataFlow.MealPlannerRecipeOperation.Response) {
        var viewModel: MealPlannerDataFlow.MealPlannerRecipeOperation.ViewModel

        defer { self.viewController?.displaySaveMealPlannerRecipe(viewModel: viewModel) }

        switch response.result {
        case .success:
            viewModel = .init(state: .saveRecipeSucceed)
        case let .error(error):
            viewModel = .init(state: .saveRecipeFailed(error))
        }
    }

    func removeMealPlannerRecipe(response: MealPlannerDataFlow.MealPlannerRecipeOperation.Response) {
        var viewModel: MealPlannerDataFlow.MealPlannerRecipeOperation.ViewModel

        defer { self.viewController?.displayRemoveMealPlannerRecipe(viewModel: viewModel) }

        switch response.result {
        case .success:
            viewModel = .init(state: .removeRecipeSucceed)
        case let .error(error):
            viewModel = .init(state: .removeRecipeFailed(error))
        }
    }
}
