//
//  ResultListService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol ResultListServiceProtocol {
    func getRecipesByCommunityID(
        request: ResultListDataFlow.GetRecipesByCommunityID.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func getEverything(
        request: ResultListDataFlow.GetEverything.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func getSavedRecipes(
        request: ResultListDataFlow.GetSavedRecipes.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func getRecipes(
        request: ResultListDataFlow.GetRecipes.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func getCommunities(
        request: ResultListDataFlow.GetCommunities.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func saveRecipe(
        request: ResultListDataFlow.SaveRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func joinCommunity(
        request: ResultListDataFlow.JoinCommunity.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class ResultListService: ResultListServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<ResultListEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<ResultListEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - ResultListServiceProtocol

    func getRecipesByCommunityID(
        request: ResultListDataFlow.GetRecipesByCommunityID.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getRecipesByCommunityID(request.body)) { result in
            completion(result)
        }
    }

    func getEverything(
        request: ResultListDataFlow.GetEverything.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getEverything(query: request.query)) { result in
            completion(result)
        }
    }

    func getSavedRecipes(
        request: ResultListDataFlow.GetSavedRecipes.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getSavedRecipes(request.body))
        { result in
            completion(result)
        }
    }

    func getRecipes(
        request: ResultListDataFlow.GetRecipes.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getRecipes(request.body))
        { result in
            completion(result)
        }
    }

    func getCommunities(
        request: ResultListDataFlow.GetCommunities.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getCommunities(request.body))
        { result in
            completion(result)
        }
    }

    func saveRecipe(
        request: ResultListDataFlow.SaveRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .saveRecipe(id: request.id)) { result in
            completion(result)
        }
    }

    func joinCommunity(request: ResultListDataFlow.JoinCommunity.Request, completion: @escaping ((AKResult) -> Void)) {
        provider.send(target: .joinCommunity(id: request.id)) { result in
            completion(result)
        }
    }
}
