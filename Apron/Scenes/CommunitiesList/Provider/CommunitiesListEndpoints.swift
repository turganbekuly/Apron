//
//  CommunitiesListEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations
import AKNetwork
import Storages

enum CommunitiesListEndpoint {
    case getCommunities(body: CommunitiesListRequestBody)
}

extension CommunitiesListEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        return Configurations.getBaseURL()
    }
    
    var path: String {
        switch self {
        case .getCommunities:
            return "communities"
        }
    }
    
    var method: AKNetworkMethod {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: AKNetworkTask {
        switch self {
        case let .getCommunities(body):
            return .requestParameters(
                parameters: [
                    "page": "\(body.pageNumber)",
                    "limit": "20",
                    "communityCategoryId": "\(body.id)"
                ],
                encoding: AKURLEncoding.queryString
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
