//
//  MealPlannerInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

protocol MealPlannerBusinessLogic {
    func getMealPlannerRecipes(
        request: MealPlannerDataFlow.GetMealPlannerRecipes.Request
    )
    func saveMealPlannerRecipe(
        request: MealPlannerDataFlow.MealPlannerRecipeOperation.Request
    )
    func removeMealPlannerRecipe(
        request: MealPlannerDataFlow.MealPlannerRecipeOperation.Request
    )
}

final class MealPlannerInteractor: MealPlannerBusinessLogic {
    // MARK: - Properties
    private let presenter: MealPlannerPresentationLogic
    private let provider: MealPlannerProviderProtocol

    // MARK: - Initialization
    init(presenter: MealPlannerPresentationLogic,
         provider: MealPlannerProviderProtocol = MealPlannerProvider()) {
        self.presenter = presenter
        self.provider = provider
    }

    // MARK: - MealPlannerBusinessLogic

    func getMealPlannerRecipes(request: MealPlannerDataFlow.GetMealPlannerRecipes.Request) {
        provider.getMealPlannerRecipes(request: request) { [weak self] in
            switch $0 {
            case let .success(model):
                self?.presenter.getMealPlannerRecipes(response: .init(result: .success(model)))
            case let .error(error):
                self?.presenter.getMealPlannerRecipes(response: .init(result: .error(error)))
            }
        }
    }

    func saveMealPlannerRecipe(request: MealPlannerDataFlow.MealPlannerRecipeOperation.Request) {
        provider.saveMealPlannerRecipe(request: request) { [weak self] in
            switch $0 {
            case .success:
                self?.presenter.saveMealPlannerRecipe(response: .init(result: .success))
            case let .error(error):
                self?.presenter.saveMealPlannerRecipe(response: .init(result: .error(error)))
            }
        }
    }

    func removeMealPlannerRecipe(request: MealPlannerDataFlow.MealPlannerRecipeOperation.Request) {
        provider.removeMealPlannerRecipe(request: request) { [weak self] in
            switch $0 {
            case .success:
                self?.presenter.removeMealPlannerRecipe(response: .init(result: .success))
            case let .error(error):
                self?.presenter.removeMealPlannerRecipe(response: .init(result: .error(error)))
            }
        }
    }
}
