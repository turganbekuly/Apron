//
//  MyRecipesEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Configurations
import AKNetwork
import Storages

enum MyRecipesEndpoint {
    case myRecipes
}

extension MyRecipesEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case .myRecipes:
            return "recipes/myRecipes"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .myRecipes:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: AKNetworkTask {
        switch self {
        case .myRecipes:
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
