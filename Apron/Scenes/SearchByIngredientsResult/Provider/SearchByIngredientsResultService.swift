//
//  SearchByIngredientsResultService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models

protocol SearchByIngredientsResultServiceProtocol {
    func getRecipesByIngredients(
        request: SearchByIngredientsResultDataFlow.GetRecipesByIngredients.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class SearchByIngredientsResultService: SearchByIngredientsResultServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<SearchByIngredientsResultEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<SearchByIngredientsResultEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - SearchByIngredientsResultServiceProtocol
    
    func getRecipesByIngredients(
        request: SearchByIngredientsResultDataFlow.GetRecipesByIngredients.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getRecipes(body: request.body)) { result in
            completion(result)
        }
    }
}
