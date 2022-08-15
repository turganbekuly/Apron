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
    case deleteprofile(Int)
}

extension ProfileEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        return Configurations.getBaseURL()
    }
    
    var path: String {
        switch self {
        case .getProfile:
            return "users/myProfile"
        case let .deleteprofile(id):
            return "users/\(id)"
        }
    }
    
    var method: AKNetworkMethod {
        switch self {
        case .getProfile:
            return .get
        case .deleteprofile:
            return .delete
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: AKNetworkTask {
        switch self {
        case .getProfile:
            return .requestPlain
        case .deleteprofile:
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
