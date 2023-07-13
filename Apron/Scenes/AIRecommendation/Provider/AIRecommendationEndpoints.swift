//
//  AIRecommendationEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27/05/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Configurations

import Storages
import Models

enum AIRecommendationEndpoint {
    case chatGPT(body: SearchAIRecommendationRequestBody)
}

extension AIRecommendationEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.openai.com/v1/")!
    }
    
    var path: String {
        return "chat/completions"
    }
    
    var method: AKNetworkMethod {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: AKNetworkTask {
        switch self {
        case let .chatGPT(body):
            return .requestParameters(
                parameters: body.toJSON(),
                encoding: AKJSONEncoding.default
            )
        }
    }
    
    var headers: [String: String]? {
        var headers = [
            "Content-Type": "application/json"
        ]
        headers["Authorization"] = "Bearer \(Configurations.getOpenAIAPIKey())"
        return headers
    }
    
}
