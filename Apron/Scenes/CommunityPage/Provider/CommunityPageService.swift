//
//  CommunityPageService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol CommunityPageServiceProtocol {
    func getCommunity(
        request: CommunityPageDataFlow.GetCommunity.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func joinCommunity(
        request: CommunityPageDataFlow.JoinCommunity.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func getRecipesByCommunity(
        request: CommunityPageDataFlow.GetRecipesByCommunity.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func saveRecipe(
        request: CommunityPageDataFlow.SaveRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class CommunityPageService: CommunityPageServiceProtocol {

    // MARK: - Properties
    private let provider: AKNetworkProvider<CommunityPageEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<CommunityPageEndpoint>) {
        self.provider = provider
    }

    // MARK: - CommunityPageServiceProtocol

    func getCommunity(
        request: CommunityPageDataFlow.GetCommunity.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getCommunity(id: request.id)) { result in
            completion(result)
        }
    }

    func joinCommunity(
        request: CommunityPageDataFlow.JoinCommunity.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .joinCommunity(id: request.id)) { result in
            completion(result)
        }
    }

    func getRecipesByCommunity(
        request: CommunityPageDataFlow.GetRecipesByCommunity.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(
            target: .getRecipesByCommunity(
                id: request.id,
                currentPage: request.currentPage
            )
        ) { result in
            completion(result)
        }
    }

    func saveRecipe(
        request: CommunityPageDataFlow.SaveRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .saveRecipe(id: request.id)) { result in
            completion(result)
        }
    }
}
