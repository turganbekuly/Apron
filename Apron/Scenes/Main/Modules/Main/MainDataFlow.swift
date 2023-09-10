//
//  MainDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models


public enum MainDataFlow {

}

extension MainDataFlow {
    enum GetCommunities {
        struct Request {

        }
        struct Response {
            let result: GetCommunitiesResult
        }
        struct ViewModel {
            var state: MainViewController.State
        }
    }

    enum GetCommunitiesResult {
        case successful(model: [CommunityCategory])
        case failed(error: AKNetworkError)
    }
}

extension MainDataFlow {
    enum GetCookNowRecipes {
        struct Request {
            let body: SearchFilterRequestBody
        }
        struct Response {
            let result: GetCookNowRecipesResult
        }
        struct ViewModel {
            var state: MainViewController.State
        }
    }

    enum GetCookNowRecipesResult {
        case successful(model: [RecipeResponse])
        case failed(error: AKNetworkError)
    }
}

extension MainDataFlow {
    enum GetEventRecipes {
        struct Request {
            let body: SearchFilterRequestBody
        }
        struct Response {
            let result: GetEventRecipesResult
        }
        struct ViewModel {
            var state: MainViewController.State
        }
    }

    enum GetEventRecipesResult {
        case successful(model: [RecipeResponse])
        case failed(error: AKNetworkError)
    }
}

extension MainDataFlow {
    enum GetCommunity {
        struct Request {
            let id: Int
        }
        struct Response {
            let result: GetCommunityResult
        }
        struct ViewModel {
            var state: MainViewController.State
        }
    }

    enum GetCommunityResult {
    case successful(model: CommunityResponse)
    case failed(error: AKNetworkError)
    }
}

extension MainDataFlow {
    enum SaveRecipe {
        struct Request {
            let id: Int
        }
        struct Response {
            let result: SaveRecipeResult
        }
        struct ViewModel {
            var state: MainViewController.State
        }
    }

    enum SaveRecipeResult {
        case successful(model: RecipeResponse)
        case failed(error: AKNetworkError)
    }
}

extension MainDataFlow {
    enum GetTrendings {
        struct Request {
            let id: Int
        }
        struct Response {
            let result: GetTrendingsResult
        }
        struct ViewModel {
            var state: MainViewController.State
        }
    }
    
    enum GetTrendingsResult {
        case successful(model: [RecipeResponse])
        case failed(error: AKNetworkError)
    }
}

extension MainDataFlow {
    enum GetProductsByIDs {
        struct Request {
            let ids: [Int]
        }
        struct Response {
            let result: GetProductsByIDsResult
        }
        struct ViewModel {
            var state: MainViewController.State
        }
    }
    
    enum GetProductsByIDsResult {
        case success(model: [Product])
        case error(error: AKNetworkError)
    }
}
