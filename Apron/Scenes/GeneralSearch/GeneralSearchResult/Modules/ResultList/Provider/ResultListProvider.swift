//
//  ResultListProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork
import Models

protocol ResultListProviderProtocol {
    func getRecipesByCommunityID(
        request: ResultListDataFlow.GetRecipesByCommunityID.Request,
        completion: @escaping ((ResultListDataFlow.GetRecipesByCommunityIDResult) -> Void)
    )
}

final class ResultListProvider: ResultListProviderProtocol {

    // MARK: - Properties
    private let service: ResultListServiceProtocol
    
    // MARK: - Init
    init(service: ResultListServiceProtocol =
                    ResultListService(provider: AKNetworkProvider<ResultListEndpoint>())) {
        self.service = service
    }
    
    // MARK: - ResultListProviderProtocol

    func getRecipesByCommunityID(
        request: ResultListDataFlow.GetRecipesByCommunityID.Request,
        completion: @escaping ((ResultListDataFlow.GetRecipesByCommunityIDResult) -> Void)
    ) {
        service.getRecipesByCommunityID(request: request) {
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
