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
    case getProfile
}

extension MyRecipesEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case .getProfile:
            return "users/myProfile"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .getProfile:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: AKNetworkTask {
        switch self {
        case .getProfile:
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
