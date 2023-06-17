//
//  MealPlannerProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//


import Models

protocol MealPlannerProviderProtocol {
    func getMealPlannerRecipes(
        request: MealPlannerDataFlow.GetMealPlannerRecipes.Request,
        completion: @escaping ((MealPlannerDataFlow.MealPlannerRecipesResponse) -> Void)
    )
    func saveMealPlannerRecipe(
        request: MealPlannerDataFlow.MealPlannerRecipeOperation.Request,
        completion: @escaping ((MealPlannerDataFlow.MealPlannerRecipeOperationResponse) -> Void)
    )
    func removeMealPlannerRecipe(
        request: MealPlannerDataFlow.MealPlannerRecipeOperation.Request,
        completion: @escaping ((MealPlannerDataFlow.MealPlannerRecipeOperationResponse) -> Void)
    )
}

final class MealPlannerProvider: MealPlannerProviderProtocol {
    // MARK: - Properties
    private let service: MealPlannerServiceProtocol

    // MARK: - Init
    init(service: MealPlannerServiceProtocol =
                    MealPlannerService(provider: AKNetworkProvider<MealPlannerEndpoint>())) {
        self.service = service
    }

    // MARK: - MealPlannerProviderProtocol

    func getMealPlannerRecipes(
        request: MealPlannerDataFlow.GetMealPlannerRecipes.Request,
        completion: @escaping ((MealPlannerDataFlow.MealPlannerRecipesResponse) -> Void)
    ) {
        service.getMealPlannerRecipes(request: request) {
            switch $0 {
            case let .success(json):
                if let jsons = json["data"] as? [JSON] {
                    completion(.success(jsons.compactMap { MealPlannerResponse(json: $0)} ))
                } else {
                    completion(.error(.invalidData))
                }
            case let .failure(error):
                completion(.error(error))
            }
        }
    }

    func saveMealPlannerRecipe(
        request: MealPlannerDataFlow.MealPlannerRecipeOperation.Request,
        completion: @escaping ((MealPlannerDataFlow.MealPlannerRecipeOperationResponse) -> Void)
    ) {
        service.saveMealPlannerRecipe(request: request) {
            switch $0 {
            case .success:
                completion(.success)
            case let .failure(error):
                completion(.error(error))
            }
        }
    }

    func removeMealPlannerRecipe(
        request: MealPlannerDataFlow.MealPlannerRecipeOperation.Request,
        completion: @escaping ((MealPlannerDataFlow.MealPlannerRecipeOperationResponse) -> Void)
    ) {
        service.removeMealPlannerRecipe(request: request) {
            switch $0 {
            case .success:
                completion(.success)
            case let .failure(error):
                completion(.error(error))
            }
        }
    }
}
