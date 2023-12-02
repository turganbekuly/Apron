//
//  SearchByIngredientsResultProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models

protocol SearchByIngredientsResultProviderProtocol {
    func getRecipesByIngredients(
        request: SearchByIngredientsResultDataFlow.GetRecipesByIngredients.Request,
        completion: @escaping ((SearchByIngredientsResultDataFlow.GetRecipesByIngredientsResult) -> Void)
    )
}

final class SearchByIngredientsResultProvider: SearchByIngredientsResultProviderProtocol {

    // MARK: - Properties
    private let service: SearchByIngredientsResultServiceProtocol
    
    // MARK: - Init
    init(service: SearchByIngredientsResultServiceProtocol =
                    SearchByIngredientsResultService(provider: AKNetworkProvider<SearchByIngredientsResultEndpoint>())) {
        self.service = service
    }
    
    // MARK: - SearchByIngredientsResultProviderProtocol

    func getRecipesByIngredients(
        request: SearchByIngredientsResultDataFlow.GetRecipesByIngredients.Request,
        completion: @escaping ((SearchByIngredientsResultDataFlow.GetRecipesByIngredientsResult) -> Void)
    ) {
        service.getRecipesByIngredients(request: request) {
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
