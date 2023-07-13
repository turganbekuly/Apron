//
//  IngredientSelectionService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//


import Models

protocol IngredientSelectionServiceProtocol {
    func getProducts(
        request: IngredientSelectionDataFlow.GetProducts.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class IngredientSelectionService: IngredientSelectionServiceProtocol {

    // MARK: - Properties
    private let provider: AKNetworkProvider<IngredientSelectionEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<IngredientSelectionEndpoint>) {
        self.provider = provider
    }

    // MARK: - IngredientSelectionServiceProtocol

    func getProducts(
        request: IngredientSelectionDataFlow.GetProducts.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getProducts(query: request.query)) { result in
            completion(result)
        }
    }

}
