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

enum RecipePageEndpoint {
    case getRecipe(id: Int)
}

extension RecipePageEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        return Configurations.getBaseURL()
    }
    
    var path: String {
        switch self {
        case .getRecipe(let id):
            return "recipes/\(id)"
        }
    }
    
    var method: AKNetworkMethod {
        return .get
    }
    
    var task: AKNetworkTask {
        return .requestPlain
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
