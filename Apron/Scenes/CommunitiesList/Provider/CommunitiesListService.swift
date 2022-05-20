//
//  CommunitiesListService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol CommunitiesListServiceProtocol {
    func getCommunities(
        request: CommunitiesListDataFlow.GetCommunities.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class CommunitiesListService: CommunitiesListServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<CommunitiesListEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<CommunitiesListEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - CommunitiesListServiceProtocol

    func getCommunities(
        request: CommunitiesListDataFlow.GetCommunities.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(
            target: .getCommunities(body: CommunitiesListRequestBody(
                pageNumber: request.pageNumber,
                id: request.id
            ))
        ) { result in
            completion(result)
        }
    }
}
