//
//  SearchByIngredientsService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

protocol SearchByIngredientsServiceProtocol {
    func getProductsByIds(
        request: SearchByIngredientsDataFlow.GetProductsByIDs.Request,
        completion: @escaping (AKResult) -> Void
    )
    
    func getProductsByName(
        request: SearchByIngredientsDataFlow.GetProductsByName.Request,
        completion: @escaping (AKResult) -> Void
    )
}

final class SearchByIngredientsService: SearchByIngredientsServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<SearchByIngredientsEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<SearchByIngredientsEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - SearchByIngredientsServiceProtocol
    
    func getProductsByIds(
        request: SearchByIngredientsDataFlow.GetProductsByIDs.Request,
        completion: @escaping (AKResult) -> Void
    ) {
        provider.send(target: .getSuggestedProducts(ids: request.ids)) { result in
            completion(result)
        }
    }
    
    func getProductsByName(
        request: SearchByIngredientsDataFlow.GetProductsByName.Request,
        completion: @escaping (AKResult) -> Void
    ) {
        provider.send(target: .getProducts(name: request.name)) { result in
            completion(result)
        }
    }
}
