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
