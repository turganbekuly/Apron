//
//  RecipeSearchProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//


import Models

protocol RecipeSearchProviderProtocol {
    func getRecipes(
        request: RecipeSearchDataFlow.GetRecipes.Request,
        completion: @escaping ((RecipeSearchDataFlow.GetRecipesResult) -> Void)
    )

    func saveRecipe(
        request: RecipeSearchDataFlow.SaveRecipe.Request,
        completion: @escaping ((RecipeSearchDataFlow.SaveRecipeResult) -> Void)
    )
}

final class RecipeSearchProvider: RecipeSearchProviderProtocol {
    // MARK: - Properties
    private let service: RecipeSearchServiceProtocol

    // MARK: - Init
    init(service: RecipeSearchServiceProtocol =
                    RecipeSearchService(provider: AKNetworkProvider<RecipeSearchEndpoint>())) {
        self.service = service
    }

    // MARK: - RecipeSearchProviderProtocol

    func getRecipes(
        request: RecipeSearchDataFlow.GetRecipes.Request,
        completion: @escaping ((RecipeSearchDataFlow.GetRecipesResult) -> Void)
    ) {
        service.getRecipes(request: request) {
            switch $0 {
            case let .success(json):
                if let jsons = json["data"] as? [JSON] {
                    completion(.successful(model: jsons.compactMap { RecipeResponse(json: $0) }))
                } else {
                    completion(.failed(error: .invalidData))
                }
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }

    func saveRecipe(
        request: RecipeSearchDataFlow.SaveRecipe.Request,
        completion: @escaping ((RecipeSearchDataFlow.SaveRecipeResult) -> Void)
    ) {
        service.saveRecipe(request: request) {
            switch $0 {
            case let .success(json):
                if let jsons = RecipeResponse(json: json) {
                    completion(.successful(model: jsons))
                } else {
                    completion(.failed(error: .invalidData))
                }
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }
}
