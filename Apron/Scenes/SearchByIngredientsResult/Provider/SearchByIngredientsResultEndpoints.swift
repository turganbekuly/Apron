//
//  SearchByIngredientsResultEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Configurations
import Storages
import Extensions

enum SearchByIngredientsResultEndpoint {
    case getRecipes(body: SearchByIngredientsResult)
}

extension SearchByIngredientsResultEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        return Configurations.getBaseURL()
    }
    
    var path: String {
        switch self {
        case .getRecipes:
//            return "recipes/getRecipesByProductIds"
            return "recipes/getMongoRecipesByProductIds"
        }
    }
    
    var method: AKNetworkMethod {
        switch self {
        case .getRecipes:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: AKNetworkTask {
        switch self {
        case let .getRecipes(body):
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
