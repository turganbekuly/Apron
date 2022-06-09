//
//  RecipePageProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork
import Models

protocol RecipePageProviderProtocol {
    func getRecipe(
        request: RecipePageDataFlow.GetRecipe.Request,
        completion: @escaping (RecipePageDataFlow.GetRecipeResult) -> Void
    )
    func rateRecipe(
        request: RecipePageDataFlow.RateRecipe.Request,
        completion: @escaping (RecipePageDataFlow.RateRecipeResult) -> Void
    )
}

final class RecipePageProvider: RecipePageProviderProtocol {

    // MARK: - Properties
    private let service: RecipePageServiceProtocol
    
    // MARK: - Init
    init(service: RecipePageServiceProtocol =
                    RecipePageService(provider: AKNetworkProvider<RecipePageEndpoint>())) {
        self.service = service
    }
    
    // MARK: - RecipePageProviderProtocol

    func getRecipe(
        request: RecipePageDataFlow.GetRecipe.Request,
        completion: @escaping (RecipePageDataFlow.GetRecipeResult) -> Void
    ) {
        service.getRecipe(request: request) {
            switch $0 {
            case let .success(json):
                if let recipe = RecipeResponse(json: json) {
                    completion(.successfull(model: recipe))
                } else {
                    completion(.failed(error: .invalidData))
                }
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }

    func rateRecipe(
        request: RecipePageDataFlow.RateRecipe.Request,
        completion: @escaping (RecipePageDataFlow.RateRecipeResult) -> Void
    ) {
        service.rateRecipe(request: request) {
            switch $0 {
            case let .success(json):
                if let rating = RatingResponse(json: json) {
                    completion(.successful(model: rating))
                } else {
                    completion(.failed(error: .invalidData))
                }
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }
}
