//
//  SavedRecipesProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//


import Models

protocol SavedRecipesProviderProtocol {
    func getSavedRecipes(
        request: SavedRecipesDataFlow.GetSavedRecipe.Request,
        completion: @escaping ((SavedRecipesDataFlow.GetSavedRecipeResult) -> Void)
    )
}

final class SavedRecipesProvider: SavedRecipesProviderProtocol {

    // MARK: - Properties
    private let service: SavedRecipesServiceProtocol

    // MARK: - Init
    init(service: SavedRecipesServiceProtocol =
                    SavedRecipesService(provider: AKNetworkProvider<SavedRecipesEndpoint>())) {
        self.service = service
    }

    // MARK: - SavedRecipesProviderProtocol

    func getSavedRecipes(
        request: SavedRecipesDataFlow.GetSavedRecipe.Request,
        completion: @escaping ((SavedRecipesDataFlow.GetSavedRecipeResult) -> Void)
    ) {
        service.getSavedRecipes(request: request) {
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
}
