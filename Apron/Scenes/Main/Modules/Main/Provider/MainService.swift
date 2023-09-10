//
//  MainService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//


import Models

protocol MainServiceProtocol {
    func getCommunity(
        request: MainDataFlow.GetCommunity.Request,
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
    func getEventRecipes(
        request: MainDataFlow.GetEventRecipes.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func saveRecipe(
        request: MainDataFlow.SaveRecipe.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func getTrendings(
        request: MainDataFlow.GetTrendings.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func getProductsByIds(
        request: MainDataFlow.GetProductsByIDs.Request,
        completion: @escaping (AKResult) -> Void
    )
}

final class MainService: MainServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<MainEndpoint>
    
    // MARK: - Init
    init(provider: AKNetworkProvider<MainEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - RecipePageServiceProtocol
    
    func getCommunity(
        request: MainDataFlow.GetCommunity.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getCommunity(id: request.id)) { result in
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
    
    func getEventRecipes(
        request: MainDataFlow.GetEventRecipes.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getEventRecipes(body: request.body)) { result in
            completion(result)
        }
    }
    
    func saveRecipe(request: MainDataFlow.SaveRecipe.Request, completion: @escaping ((AKResult) -> Void)) {
        provider.send(target: .saveRecipe(id: request.id)) { result in
            completion(result)
        }
    }
    
    func getTrendings(
        request: MainDataFlow.GetTrendings.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .trendingsRecommendations(id: request.id)) { result in
            completion(result)
        }
    }
    
    func getProductsByIds(
        request: MainDataFlow.GetProductsByIDs.Request,
        completion: @escaping (AKResult) -> Void
    ) {
        provider.send(target: .getSuggestedProducts(ids: request.ids)) { result in
            completion(result)
        }
    }
}
