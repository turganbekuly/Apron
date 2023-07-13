//
//  MealPlannerService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models

protocol MealPlannerServiceProtocol {
    func getMealPlannerRecipes(
        request: MealPlannerDataFlow.GetMealPlannerRecipes.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func saveMealPlannerRecipe(
        request: MealPlannerDataFlow.MealPlannerRecipeOperation.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func removeMealPlannerRecipe(
        request: MealPlannerDataFlow.MealPlannerRecipeOperation.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class MealPlannerService: MealPlannerServiceProtocol {

    // MARK: - Properties
    private let provider: AKNetworkProvider<MealPlannerEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<MealPlannerEndpoint>) {
        self.provider = provider
    }

    // MARK: - MealPlannerServiceProtocol

    func getMealPlannerRecipes(
        request: MealPlannerDataFlow.GetMealPlannerRecipes.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(
            target: .getRecipes(startDate: request.startDate, endDate: request.endDate)
        ) { result in
                completion(result)
        }
    }

    func saveMealPlannerRecipe(
        request: MealPlannerDataFlow.MealPlannerRecipeOperation.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .saveRecipe(body: request.body)) { result in
            completion(result)
        }
    }

    func removeMealPlannerRecipe(
        request: MealPlannerDataFlow.MealPlannerRecipeOperation.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .deleteRecipe(body: request.body)) { result in
            completion(result)
        }
    }
}
