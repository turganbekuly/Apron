//
//  CommunitiesListProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork
import Models

protocol CommunitiesListProviderProtocol {
    func getCommunities(
        request: CommunitiesListDataFlow.GetCommunities.Request,
        completion: @escaping ((CommunitiesListDataFlow.GetCommunitiesResult) -> Void)
    )
}

final class CommunitiesListProvider: CommunitiesListProviderProtocol {

    // MARK: - Properties
    private let service: CommunitiesListServiceProtocol
    
    // MARK: - Init
    init(service: CommunitiesListServiceProtocol =
                    CommunitiesListService(provider: AKNetworkProvider<CommunitiesListEndpoint>())) {
        self.service = service
    }
    
    // MARK: - CommunitiesListProviderProtocol

    func getCommunities(
        request: CommunitiesListDataFlow.GetCommunities.Request,
        completion: @escaping ((CommunitiesListDataFlow.GetCommunitiesResult) -> Void)
    ) {
        service.getCommunities(request: request) {
            switch $0 {
            case let .success(json):
                if let jsons = json["data"] as? [JSON] {
                    completion(.successful(model: jsons.compactMap { CommunityResponse(json: $0) }))
                } else {
                    completion(.failed(error: .invalidData))
                }
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }
}
