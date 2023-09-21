//
//  MainProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//


import Models

protocol MainProviderProtocol {
    func getCommunity(
        request: MainDataFlow.GetCommunity.Request,
        completion: @escaping (MainDataFlow.GetCommunityResult) -> Void
    )
    
    func getCommunitiesByCategory(
        request: MainDataFlow.GetCommunities.Request,
        completion: @escaping (MainDataFlow.GetCommunitiesResult) -> Void
    )

    func getCookNowRecipes(
        request: MainDataFlow.GetCookNowRecipes.Request,
        completion: @escaping (MainDataFlow.GetCookNowRecipesResult) -> Void
    )

    func getEventRecipes(
        request: MainDataFlow.GetEventRecipes.Request,
        completion: @escaping (MainDataFlow.GetEventRecipesResult) -> Void
    )

    func saveRecipe(
        request: MainDataFlow.SaveRecipe.Request,
        completion: @escaping ((MainDataFlow.SaveRecipeResult) -> Void)
    )
    func getTrendings(
        request: MainDataFlow.GetTrendings.Request,
        completion: @escaping ((MainDataFlow.GetTrendingsResult) -> Void )
    )
    
    func getProductsByIds(
        request: MainDataFlow.GetProductsByIDs.Request,
        completion: @escaping (MainDataFlow.GetProductsByIDsResult) -> Void
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
    
    func getCommunity(
        request: MainDataFlow.GetCommunity.Request,
        completion: @escaping (MainDataFlow.GetCommunityResult) -> Void
    ) {
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

    func getEventRecipes(
        request: MainDataFlow.GetEventRecipes.Request,
        completion: @escaping (MainDataFlow.GetEventRecipesResult) -> Void
    ) {
        service.getEventRecipes(request: request) {
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
    
    func getTrendings(
        request: MainDataFlow.GetTrendings.Request,
        completion: @escaping ((MainDataFlow.GetTrendingsResult) -> Void )
    ) {
        service.getTrendings(request: request) {
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
    
    func getProductsByIds(
        request: MainDataFlow.GetProductsByIDs.Request,
        completion: @escaping (MainDataFlow.GetProductsByIDsResult) -> Void
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
}
