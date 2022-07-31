//
//  RecipePageService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork
import Models

protocol RecipePageServiceProtocol {
    func getRecipe(
        request: RecipePageDataFlow.GetRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func rateRecipe(
        request: RecipePageDataFlow.RateRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func saveRecipe(
        request: RecipePageDataFlow.SaveRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func getComments(
        request: RecipePageDataFlow.GetComments.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class RecipePageService: RecipePageServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<RecipePageEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<RecipePageEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - RecipePageServiceProtocol

    func getRecipe(
        request: RecipePageDataFlow.GetRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getRecipe(id: request.id)) { result in
            completion(result)
        }
    }

    func rateRecipe(
        request: RecipePageDataFlow.RateRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .rateRecipe(body: request.body)) { result in
            completion(result)
        }
    }

    func saveRecipe(
        request: RecipePageDataFlow.SaveRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .saveRecipe(id: request.id)) { result in
            completion(result)
        }
    }

    func getComments(
        request: RecipePageDataFlow.GetComments.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getCommentsByRecipe(id: request.recipeId)) { result in
            completion(result)
        }
    }
}
