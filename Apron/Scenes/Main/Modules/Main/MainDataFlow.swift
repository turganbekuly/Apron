//
//  MainDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import AKNetwork

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
    enum JoinCommunity {
        struct Request {
            let id: Int
        }
        struct Response {
            let result: JoinCommunityResult
        }
        struct ViewModel {
            var state: MainViewController.State
        }
    }

    enum JoinCommunityResult {
        case successfull
        case failed(error: AKNetworkError)
    }
}
