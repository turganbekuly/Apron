//
//  RecipeSearchService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol RecipeSearchServiceProtocol {
    func getRecipes(
        request: RecipeSearchDataFlow.GetRecipes.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func saveRecipe(
        request: RecipeSearchDataFlow.SaveRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class RecipeSearchService: RecipeSearchServiceProtocol {
    // MARK: - Properties
    private let provider: AKNetworkProvider<RecipeSearchEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<RecipeSearchEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - RecipeSearchServiceProtocol

    func getRecipes(request: RecipeSearchDataFlow.GetRecipes.Request, completion: @escaping ((AKResult) -> Void)) {
        provider.send(target: .getRecipes(request.body))
        { result in
            completion(result)
        }
    }

    func saveRecipe(request: RecipeSearchDataFlow.SaveRecipe.Request, completion: @escaping ((AKResult) -> Void)) {
        provider.send(target: .saveRecipe(id: request.id)) { result in
            completion(result)
        }
    }
}
