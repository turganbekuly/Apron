//
//  CommunityCreationEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations
import AKNetwork
import Storages
import Models

enum CommunityCreationEndpoint {
    case communityCreation(CommunityCreation)
}

extension CommunityCreationEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        return Configurations.getBaseURL()
    }
    
    var path: String {
        switch self {
        case .communityCreation:
            return "communities"
        }
    }
    
    var method: AKNetworkMethod {
        switch self {
        case .communityCreation:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: AKNetworkTask {
        switch self {
        case .communityCreation(let communityCreation):
            return .requestParameters(
                parameters: communityCreation.toJSON(),
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
