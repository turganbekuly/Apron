//
//  ProfileEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations
import AKNetwork
import Storages

enum ProfileEndpoint {
    case getProfile
}

extension ProfileEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        return Configurations.getBaseURL()
    }
    
    var path: String {
        return "users/myProfile"
    }
    
    var method: AKNetworkMethod {
        return .get
    }
    
    var sampleData: Data {
        return Data()
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
