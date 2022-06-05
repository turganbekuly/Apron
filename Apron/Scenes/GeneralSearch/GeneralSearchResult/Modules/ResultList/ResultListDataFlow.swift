//
//  ResultListDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

enum ResultListDataFlow {
    
}

extension ResultListDataFlow {
    enum GetRecipesByCommunityID {
        struct Request {
            let body: RecipesByCommunityIDRequestBody
        }
        struct Response {
            let result: GetRecipesByCommunityIDResult
        }
        struct ViewModel {
            var state: ResultListViewController.State
        }
    }

    enum GetRecipesByCommunityIDResult {
        case successful(model: [RecipeResponse])
        case failed(error: AKNetworkError)
    }
}

extension ResultListDataFlow {
    enum GetEverything {
        struct Request {
            let query: String
        }
        struct Response {
            let result: GetEverythingResult
        }
        struct ViewModel {
            var state: ResultListViewController.State
        }
    }

    enum GetEverythingResult {
        case successful(model: SearchEverythingResponse)
        case failed(error: AKNetworkError)
    }
}

extension ResultListDataFlow {
    enum GetSavedRecipes {
        struct Request {
            let query: String
            let currentPage: Int
        }
        struct Response {
            let result: GetSavedRecipesResult
        }
        struct ViewModel {
            var state: ResultListViewController.State
        }
    }

    enum GetSavedRecipesResult {
        case successful(model: [RecipeResponse])
        case failed(error: AKNetworkError)
    }
}

extension ResultListDataFlow {
    enum GetRecipes {
        struct Request {
            let query: String
            let currentPage: Int
        }
        struct Response {
            let result: GetRecipesResult
        }
        struct ViewModel {
            var state: ResultListViewController.State
        }
    }

    enum GetRecipesResult {
        case successful(model: [RecipeResponse])
        case failed(error: AKNetworkError)
    }
}

extension ResultListDataFlow {
    enum GetCommunities {
        struct Request {
            let query: String
            let currentPage: Int
        }
        struct Response {
            let result: GetCommunitiesResult
        }
        struct ViewModel {
            var state: ResultListViewController.State
        }
    }

    enum GetCommunitiesResult {
        case successful(model: [CommunityResponse])
        case failed(error: AKNetworkError)
    }
}

