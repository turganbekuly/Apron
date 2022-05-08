//
//  IngredientSelectionProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork
import Models
import StoreKit

protocol IngredientSelectionProviderProtocol {
    func getProducts(
        request: IngredientSelectionDataFlow.GetProducts.Request,
        completion: @escaping ((IngredientSelectionDataFlow.GetProductsResult) -> Void)
    )
}

final class IngredientSelectionProvider: IngredientSelectionProviderProtocol {

    // MARK: - Properties
    private let service: IngredientSelectionServiceProtocol
    
    // MARK: - Init
    init(service: IngredientSelectionServiceProtocol =
                    IngredientSelectionService(provider: AKNetworkProvider<IngredientSelectionEndpoint>())) {
        self.service = service
    }
    
    // MARK: - IngredientSelectionProviderProtocol

    func getProducts(
        request: IngredientSelectionDataFlow.GetProducts.Request,
        completion: @escaping ((IngredientSelectionDataFlow.GetProductsResult) -> Void)) {
            service.getProducts(request: request) {
                switch $0 {
                case let .success(json):
                    if let jsons = json["data"] as? [JSON] {
                        completion(.successful(model: jsons.compactMap { Product(json: $0) }))
                    } else {
                        completion(.failed(error: .invalidData))
                    }
                case let .failure(error):
                    completion(.failed(error: error))
                }
            }
    }
}
