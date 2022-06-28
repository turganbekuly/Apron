//
//  CommunitiesListDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

enum CommunitiesListDataFlow {}

extension CommunitiesListDataFlow {
    enum GetCommunities {
        struct Request {
            let pageNumber: Int
            let id: Int
        }
        struct Response {
            let result: GetCommunitiesResult
        }
        struct ViewModel {
            var state: CommunitiesListViewController.State
        }
    }

    enum GetCommunitiesResult {
        case successful(model: [CommunityResponse])
        case failed(error: AKNetworkError)
    }
}

extension CommunitiesListDataFlow {
    enum JoinCommunity {
        struct Request {
            let id: Int
        }
        struct Response {
            let result: JoinCommunityResult
        }
        struct ViewModel {
            var state: CommunitiesListViewController.State
        }
    }

    enum JoinCommunityResult {
        case successfull
        case failed(error: AKNetworkError)
    }
}
