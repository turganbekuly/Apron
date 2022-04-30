//
//  RecipeCreationEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations
import AKNetwork
import Storages
import Models

enum RecipeCreationEndpoint {
    case createRecipe(RecipeCreation)
}

extension RecipeCreationEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        return Configurations.getBaseURL()
    }
    
    var path: String {
        switch self {
        case .createRecipe:
            return "recipes"
        }
    }
    
    var method: AKNetworkMethod {
        switch self {
        case .createRecipe:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: AKNetworkTask {
        switch self {
        case .createRecipe(let recipeCreation):
            return .requestParameters(
                parameters: recipeCreation.toJSON(),
                encoding: AKJSONEncoding.default
            )
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
