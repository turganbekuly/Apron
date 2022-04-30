//
//  RecipeCreationService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol RecipeCreationServiceProtocol {
    func createRecipe(
        request: RecipeCreationDataFlow.CreateRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class RecipeCreationService: RecipeCreationServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<RecipeCreationEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<RecipeCreationEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - RecipeCreationServiceProtocol

    func createRecipe(
        request: RecipeCreationDataFlow.CreateRecipe.Request,
        completion: @escaping ((AKResult) -> Void)) {
            provider.send(
                target: .createRecipe(request.recipeCreation)) { result in
                    completion(result)
                }
    }
}
