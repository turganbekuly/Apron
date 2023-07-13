//
//  AddSavedRecipesProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//


import Models

protocol AddSavedRecipesProviderProtocol {
    func getSavedRecipes(
        request: AddSavedRecipesDataFlow.GetSavedRecipe.Request,
        completion: @escaping ((AddSavedRecipesDataFlow.GetSavedRecipeResult) -> Void)
    )
    func addRecipesToCommunity(
        request: AddSavedRecipesDataFlow.AddToCommunity.Request,
        completion: @escaping ((AddSavedRecipesDataFlow.AddToCommunityResponse) -> Void)
    )
}

final class AddSavedRecipesProvider: AddSavedRecipesProviderProtocol {

    // MARK: - Properties
    private let service: AddSavedRecipesServiceProtocol

    // MARK: - Init
    init(service: AddSavedRecipesServiceProtocol =
                    AddSavedRecipesService(provider: AKNetworkProvider<AddSavedRecipesEndpoint>())) {
        self.service = service
    }

    // MARK: - AddSavedRecipesProviderProtocol

    func getSavedRecipes(
        request: AddSavedRecipesDataFlow.GetSavedRecipe.Request,
        completion: @escaping ((AddSavedRecipesDataFlow.GetSavedRecipeResult) -> Void)
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

    func addRecipesToCommunity(
        request: AddSavedRecipesDataFlow.AddToCommunity.Request,
        completion: @escaping ((AddSavedRecipesDataFlow.AddToCommunityResponse) -> Void)
    ) {
        service.addRecipesToCommunity(request: request) {
            switch $0 {
            case .success: completion(.successful)
            case let .failure(error): completion(.failed(error: error))
            }
        }
    }
}
