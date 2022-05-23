//
//  CommunityCreationDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

enum CommunityCreationDataFlow {
    
}

extension CommunityCreationDataFlow {
    enum CreateCommunity {
        struct Request {
            let communityCreation: CommunityCreation
        }
        struct Response {
            let result: CommunityCreationResult
        }
        struct ViewModel {
            var state: CommunityCreationViewController.State
        }
    }

    enum CommunityCreationResult {
    case successful(model: CommunityResponse)
    case failed(error: AKNetworkError)
    }
}
