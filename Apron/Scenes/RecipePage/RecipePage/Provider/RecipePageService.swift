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
}
