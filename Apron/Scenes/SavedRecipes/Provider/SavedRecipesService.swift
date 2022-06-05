//
//  SavedRecipesService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol SavedRecipesServiceProtocol {
    func getSavedRecipes(
        request: SavedRecipesDataFlow.GetSavedRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class SavedRecipesService: SavedRecipesServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<SavedRecipesEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<SavedRecipesEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - SavedRecipesServiceProtocol

    func getSavedRecipes(
        request: SavedRecipesDataFlow.GetSavedRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getRecipes(page: request.page)) { result in
            completion(result)
        }
    }
}
