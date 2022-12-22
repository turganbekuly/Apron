//
//  MainProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import AKNetwork
import Models

protocol MainProviderProtocol {
    func joinCommunity(
        request: MainDataFlow.JoinCommunity.Request,
        completion: @escaping (MainDataFlow.JoinCommunityResult) -> Void
    )

    func getCommunitiesByCategory(
        request: MainDataFlow.GetCommunities.Request,
        completion: @escaping (MainDataFlow.GetCommunitiesResult) -> Void
    )

    func getCookNowRecipes(
        request: MainDataFlow.GetCookNowRecipes.Request,
        completion: @escaping (MainDataFlow.GetCookNowRecipesResult) -> Void
    )

    func saveRecipe(
        request: MainDataFlow.SaveRecipe.Request,
        completion: @escaping ((MainDataFlow.SaveRecipeResult) -> Void)
    )
}

final class MainProvider: MainProviderProtocol {

    // MARK: - Properties
    private let service: MainServiceProtocol

    // MARK: - Init
    init(service: MainServiceProtocol =
         MainService(provider: AKNetworkProvider<MainEndpoint>())) {
        self.service = service
    }

    // MARK: - RecipePageProviderProtocol

    func joinCommunity(
        request: MainDataFlow.JoinCommunity.Request,
        completion: @escaping (MainDataFlow.JoinCommunityResult) -> Void
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

    func getCommunitiesByCategory(
        request: MainDataFlow.GetCommunities.Request,
        completion: @escaping (MainDataFlow.GetCommunitiesResult) -> Void
    ) {
        service.getCommunitiesByCategory(request: request) {
            switch $0 {
            case let .success(json):
                if let jsons = json["data"] as? [JSON] {
                    completion(.successful(model: jsons.compactMap { CommunityCategory(json: $0) }))
                } else {
                    completion(.failed(error: .invalidData))
                }
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }

    func getCookNowRecipes(
        request: MainDataFlow.GetCookNowRecipes.Request,
        completion: @escaping (MainDataFlow.GetCookNowRecipesResult) -> Void
    ) {
        service.getCookNowRecipes(request: request) {
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

    func saveRecipe(
        request: MainDataFlow.SaveRecipe.Request,
        completion: @escaping ((MainDataFlow.SaveRecipeResult) -> Void)
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
}
