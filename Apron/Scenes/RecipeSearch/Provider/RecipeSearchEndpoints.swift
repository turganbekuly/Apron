//
//  RecipeSearchEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations
import AKNetwork
import Models
import Storages

enum RecipeSearchEndpoint {
    case getRecipes(SearchByQueryRequestBody)
    case saveRecipe(id: Int)
}

extension RecipeSearchEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        return Configurations.getBaseURL()
    }
    
    var path: String {
        switch self {
        case .getRecipes:
            return "recipes"
        case .saveRecipe(let id):
            return "recipes/saveRecipe/\(id)"
        }
    }
    
    var method: AKNetworkMethod {
        switch self {
        case .getRecipes:
            return .get
        case .saveRecipe:
            return .put
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: AKNetworkTask {
        switch self {
        case .getRecipes(let body):
            return .requestParameters(
                parameters: body.toJSON(),
                encoding: AKURLEncoding.queryString
            )
        case .saveRecipe:
            return .requestPlain
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
