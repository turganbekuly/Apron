//
//  SearchByIngredientsProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models

protocol SearchByIngredientsProviderProtocol {
    func getProductsByIds(
        request: SearchByIngredientsDataFlow.GetProductsByIDs.Request,
        completion: @escaping (SearchByIngredientsDataFlow.GetProductsByIDsResult) -> Void
    )
    
    func getProductsByName(
        request: SearchByIngredientsDataFlow.GetProductsByName.Request,
        completion: @escaping (SearchByIngredientsDataFlow.GetProductsByNameResult) -> Void
    )
}

final class SearchByIngredientsProvider: SearchByIngredientsProviderProtocol {

    // MARK: - Properties
    private let service: SearchByIngredientsServiceProtocol
    
    // MARK: - Init
    init(service: SearchByIngredientsServiceProtocol =
                    SearchByIngredientsService(provider: AKNetworkProvider<SearchByIngredientsEndpoint>())) {
        self.service = service
    }
    
    // MARK: - SearchByIngredientsProviderProtocol

    func getProductsByIds(
        request: SearchByIngredientsDataFlow.GetProductsByIDs.Request,
        completion: @escaping (SearchByIngredientsDataFlow.GetProductsByIDsResult) -> Void
    ) {
        service.getProductsByIds(request: request) {
            switch $0 {
            case let .success(json):
                if let jsons = json["data"] as? [JSON] {
                    completion(.success(model: jsons.compactMap { Product(json: $0) }))
                } else {
                    completion(.error(error: .invalidData))
                }
            case let .failure(error):
                completion(.error(error: error))
            }
        }
    }
    
    func getProductsByName(
        request: SearchByIngredientsDataFlow.GetProductsByName.Request,
        completion: @escaping (SearchByIngredientsDataFlow.GetProductsByNameResult) -> Void
    ) {
        service.getProductsByName(request: request) {
            switch $0 {
            case let .success(json):
                if let jsons = json["data"] as? [JSON] {
                    completion(.success(model: jsons.compactMap { Product(json: $0) }))
                } else {
                    completion(.error(error: .invalidData))
                }
            case let .failure(error):
                completion(.error(error: error))
            }
        }
    }
}
