//
//  MainService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import AKNetwork
import Models

protocol MainServiceProtocol {
    func joinCommunity(
        request: MainDataFlow.JoinCommunity.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func getCommunitiesByCategory(
        request: MainDataFlow.GetCommunities.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func getCookNowRecipes(
        request: MainDataFlow.GetCookNowRecipes.Request,
        completion: @escaping ((AKResult) -> Void)
    )
//    func getMyCommunities(
//        request: MainDataFlow.GetMyCommunities.Request,
//        completion: @escaping ((AKResult) -> Void)
//    )
}

final class MainService: MainServiceProtocol {

    // MARK: - Properties
    private let provider: AKNetworkProvider<MainEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<MainEndpoint>) {
        self.provider = provider
    }

    // MARK: - RecipePageServiceProtocol

    func joinCommunity(
        request: MainDataFlow.JoinCommunity.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .joinCommunity(id: request.id)) { result in
            completion(result)
        }
    }

    func getCommunitiesByCategory(
        request: MainDataFlow.GetCommunities.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getCommuntiesByCategories) { result in
            completion(result)
        }
    }

    func getCookNowRecipes(
        request: MainDataFlow.GetCookNowRecipes.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getCookNowRecipes(body: request.body)) { result in
            completion(result)
        }
    }

//    func getMyCommunities(
//        request: MainDataFlow.GetMyCommunities.Request,
//        completion: @escaping ((AKResult) -> Void)
//    ) {
//        provider.send(target: .getMyCommunities) { result in
//            completion(result)
//        }
//    }
}
