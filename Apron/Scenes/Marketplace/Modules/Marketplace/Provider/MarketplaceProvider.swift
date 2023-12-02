//
//  MarketplaceProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models

protocol MarketplaceProviderProtocol {
    func getProducts(
        request: MarketplaceDataFlow.GetProducts.Request,
        completion: @escaping ((MarketplaceDataFlow.GetProductsResult) -> Void)
    )
}

final class MarketplaceProvider: MarketplaceProviderProtocol {

    // MARK: - Properties
    private let service: MarketplaceServiceProtocol
    
    // MARK: - Init
    init(service: MarketplaceServiceProtocol =
                    MarketplaceService(provider: AKNetworkProvider<MarketplaceEndpoint>())) {
        self.service = service
    }
    
    // MARK: - MarketplaceProviderProtocol

    func getProducts(
        request: MarketplaceDataFlow.GetProducts.Request,
        completion: @escaping ((MarketplaceDataFlow.GetProductsResult) -> Void)
    ) {
        service.getProducts(request: request) {
            switch $0 {
            case let .success(json):
                if let jsons = json["data"] as? [JSON] {
                    completion(.success(jsons.compactMap { MarketplaceItemResponseBody(json: $0) }))
                } else {
                    completion(.error(.invalidData))
                }
            case let .failure(error):
                completion(.error(error))
            }
        }
    }
}
