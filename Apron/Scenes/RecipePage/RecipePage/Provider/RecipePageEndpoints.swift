//
//  RecipePageEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations
import AKNetwork
import Storages
import Models

enum RecipePageEndpoint {
    case getRecipe(id: Int)
    case rateRecipe(body: RatingRequestBody)
}

extension RecipePageEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        return Configurations.getBaseURL()
    }
    
    var path: String {
        switch self {
        case .getRecipe(let id):
            return "recipes/\(id)"
        case .rateRecipe:
            return "likes/likeToRecipe"
        }
    }
    
    var method: AKNetworkMethod {
        switch self {
        case .getRecipe:
            return .get
        case .rateRecipe:
            return .post
        }
    }
    
    var task: AKNetworkTask {
        switch self {
        case .getRecipe:
            return .requestPlain
        case let .rateRecipe(body):
            return .requestParameters(parameters: body.toJSON(), encoding: AKJSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        var headers = [
            "Accept-Language": "ru",
            "Content-Type": "application/json"
        ]
        if let token = AuthStorage.shared.accessToken {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }
    
}
