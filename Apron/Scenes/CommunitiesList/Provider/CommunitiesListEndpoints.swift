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
    case joinCommunity(id: Int)
}

extension CommunitiesListEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        return Configurations.getBaseURL()
    }
    
    var path: String {
        switch self {
        case .getCommunities:
            return "communities"
        case let .joinCommunity(id):
            return "communities/join/\(id)"
        }
    }
    
    var method: AKNetworkMethod {
        switch self {
        case .getCommunities:
            return .get
        case .joinCommunity:
            return .put
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: AKNetworkTask {
        switch self {
        case let .getCommunities(body):
            return .requestParameters(
                parameters: [
                    "page": body.pageNumber,
                    "limit": 10,
                    "communityCategoryId": body.id
                ],
                encoding: AKURLEncoding.queryString
            )
        case .joinCommunity:
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
