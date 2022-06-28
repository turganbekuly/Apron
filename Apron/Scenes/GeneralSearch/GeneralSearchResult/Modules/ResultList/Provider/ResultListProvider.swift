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
    func getEverything(
        request: ResultListDataFlow.GetEverything.Request,
        completion: @escaping ((ResultListDataFlow.GetEverythingResult) -> Void)
    )
    func getSavedRecipes(
        request: ResultListDataFlow.GetSavedRecipes.Request,
        completion: @escaping ((ResultListDataFlow.GetSavedRecipesResult) -> Void)
    )
    func getRecipes(
        request: ResultListDataFlow.GetRecipes.Request,
        completion: @escaping ((ResultListDataFlow.GetRecipesResult) -> Void)
    )
    func getCommunities(
        request: ResultListDataFlow.GetCommunities.Request,
        completion: @escaping ((ResultListDataFlow.GetCommunitiesResult) -> Void)
    )
    func saveRecipe(
        request: ResultListDataFlow.SaveRecipe.Request,
        completion: @escaping (ResultListDataFlow.SaveRecipeResult) -> Void
    )
    func joinCommunity(
        request: ResultListDataFlow.JoinCommunity.Request,
        completion: @escaping (ResultListDataFlow.JoinCommunityResult) -> Void
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

    func getEverything(
        request: ResultListDataFlow.GetEverything.Request,
        completion: @escaping ((ResultListDataFlow.GetEverythingResult) -> Void)
    ) {
        service.getEverything(request: request) {
            switch $0 {
            case let .success(json):
                if let jsons = SearchEverythingResponse(json: json) {
                    completion(.successful(model: jsons))
                } else {
                    completion(.failed(error: .invalidData))
                }
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }

    func getSavedRecipes(
        request: ResultListDataFlow.GetSavedRecipes.Request,
        completion: @escaping ((ResultListDataFlow.GetSavedRecipesResult) -> Void)
    ) {
        service.getSavedRecipes(request: request) {
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

    func getRecipes(
        request: ResultListDataFlow.GetRecipes.Request,
        completion: @escaping ((ResultListDataFlow.GetRecipesResult) -> Void)
    ) {
        service.getRecipes(request: request) {
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

    func getCommunities(
        request: ResultListDataFlow.GetCommunities.Request,
        completion: @escaping ((ResultListDataFlow.GetCommunitiesResult) -> Void)
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

    func saveRecipe(
        request: ResultListDataFlow.SaveRecipe.Request,
        completion: @escaping (ResultListDataFlow.SaveRecipeResult) -> Void
    ) {
        service.saveRecipe(request: request) {
            switch $0 {
            case let .success(json):
                if let jsons = RecipeResponse(json: json) {
                    completion(.successful(model: jsons))
                } else {
                    completion(.failed(error: .invalidData))
                }
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }

    func joinCommunity(request: ResultListDataFlow.JoinCommunity.Request, completion: @escaping (ResultListDataFlow.JoinCommunityResult) -> Void) {
        service.joinCommunity(request: request) {
            switch $0 {
            case .success(_):
                completion(.successfull)
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }
}
