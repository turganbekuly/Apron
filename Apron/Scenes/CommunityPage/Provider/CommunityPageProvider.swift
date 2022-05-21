//
//  CommunityPageProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork
import Models

protocol CommunityPageProviderProtocol {
    func getCommunity(
        request: CommunityPageDataFlow.GetCommunity.Request,
        completion: @escaping ((CommunityPageDataFlow.GetCommunityResult) -> Void)
    )
    func joinCommunity(
        request: CommunityPageDataFlow.JoinCommunity.Request,
        completion: @escaping (CommunityPageDataFlow.JoinCommunityResult) -> Void
    )
    func getRecipesByCommunity(
        request: CommunityPageDataFlow.GetRecipesByCommunity.Request,
        completion: @escaping ((CommunityPageDataFlow.GetRecipesByCommunityResult) -> Void
        )
    )
}

final class CommunityPageProvider: CommunityPageProviderProtocol {

    // MARK: - Properties
    private let service: CommunityPageServiceProtocol
    
    // MARK: - Init
    init(service: CommunityPageServiceProtocol =
                    CommunityPageService(provider: AKNetworkProvider<CommunityPageEndpoint>())) {
        self.service = service
    }
    
    // MARK: - CommunityPageProviderProtocol

    func getCommunity(
        request: CommunityPageDataFlow.GetCommunity.Request,
        completion: @escaping ((CommunityPageDataFlow.GetCommunityResult) -> Void)) {
            service.getCommunity(request: request) {
                switch $0 {
                case let .success(json):
                    if let community = CommunityResponse(json: json) {
                        completion(.successful(model: community))
                    } else {
                        completion(.failed(error: .invalidData))
                    }
                case let .failure(error):
                    completion(.failed(error: error))
                }
            }
        }

    func joinCommunity(
        request: CommunityPageDataFlow.JoinCommunity.Request,
        completion: @escaping (CommunityPageDataFlow.JoinCommunityResult) -> Void
    ) {
        service.joinCommunity(request: request) {
            switch $0 {
            case .success(_):
                completion(.successfull)
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }

    func getRecipesByCommunity(
        request: CommunityPageDataFlow.GetRecipesByCommunity.Request,
        completion: @escaping ((CommunityPageDataFlow.GetRecipesByCommunityResult) -> Void)
    ) {
        service.getRecipesByCommunity(request: request) {
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
