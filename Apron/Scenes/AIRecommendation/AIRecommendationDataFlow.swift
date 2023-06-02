//
//  AIRecommendationDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27/05/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models

enum AIRecommendationDataFlow {}

extension AIRecommendationDataFlow {
    enum GetRecommendations {
        struct Request {
            let body: SearchAIRecommendationRequestBody
        }
        struct Response {
            let result: GetRecommendationsResult
        }
        struct ViewModel {
            var state: AIRecommendationViewController.State
        }
    }
    
    enum GetRecommendationsResult {
        case successful(SearchAIRecommendationResponseBody)
        case failed
    }
}
