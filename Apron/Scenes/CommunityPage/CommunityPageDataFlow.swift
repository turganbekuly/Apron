//
//  CommunityPageDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

enum CommunityPageDataFlow {
    
}

extension CommunityPageDataFlow {
    enum GetCommunity {
        struct Request {
            let id: Int
        }
        struct Response {
            let result: GetCommunityResult
        }
        struct ViewModel {
            var state: CommunityPageViewController.State
        }
    }

    enum GetCommunityResult {
    case successful(model: CommunityResponse)
    case failed(error: AKNetworkError)
    }
}

extension CommunityPageDataFlow {
    enum JoinCommunity {
        struct Request {
            let id: Int
        }
        struct Response {
            let result: JoinCommunityResult
        }
        struct ViewModel {
            var state: CommunityPageViewController.State
        }
    }

    enum JoinCommunityResult {
        case successfull
        case failed(error: AKNetworkError)
    }
}

extension CommunityPageDataFlow {
    enum GetRecipesByCommunity {
        struct Request {
            let id: Int
            let currentPage: Int
        }
        struct Response {
            let result: GetRecipesByCommunityResult
        }
        struct ViewModel {
            var state: CommunityPageViewController.State
        }
    }

    enum GetRecipesByCommunityResult {
        case successful(model: [RecipeResponse])
        case failed(error: AKNetworkError)
    }
}
