//
//  AddSavedRecipesService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol AddSavedRecipesServiceProtocol {
    func getSavedRecipes(
        request: AddSavedRecipesDataFlow.GetSavedRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func addRecipesToCommunity(
        request: AddSavedRecipesDataFlow.AddToCommunity.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class AddSavedRecipesService: AddSavedRecipesServiceProtocol {

    // MARK: - Properties
    private let provider: AKNetworkProvider<AddSavedRecipesEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<AddSavedRecipesEndpoint>) {
        self.provider = provider
    }

    // MARK: - AddSavedRecipesServiceProtocol

    func getSavedRecipes(
        request: AddSavedRecipesDataFlow.GetSavedRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getRecipes(page: request.page)) { result in
            completion(result)
        }
    }

    func addRecipesToCommunity(
        request: AddSavedRecipesDataFlow.AddToCommunity.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(
            target: .addToCommunity(
                id: request.communityId,
                recipes: request.recipes
            )) { result in
                completion(result)
            }
    }
}
