//
//  MarketplaceService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

protocol MarketplaceServiceProtocol {
    func getProducts(
        request: MarketplaceDataFlow.GetProducts.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class MarketplaceService: MarketplaceServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<MarketplaceEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<MarketplaceEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - MarketplaceServiceProtocol
    
    func getProducts(
        request: MarketplaceDataFlow.GetProducts.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getProducts) { result in
            completion(result)
        }
    }
}
