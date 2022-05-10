//
//  CommunityPageEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations
import AKNetwork
import Storages

public enum CommunityPageEndpoint {
    case getCommunity(id: Int)
    case joinCommunity(id: Int)
}

extension CommunityPageEndpoint: AKNetworkTargetType {
    
    public var baseURL: URL {
        return Configurations.getBaseURL()
    }
    
    public var path: String {
        switch self {
        case .getCommunity(let id):
            return "communities/\(id)"
        case let .joinCommunity(id):
            return "communities/join/\(id)"
        }
    }
    
    public var method: AKNetworkMethod {
        switch self {
        case .getCommunity:
            return .get
        case .joinCommunity:
            return .put
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: AKNetworkTask {
        switch self {
        case .getCommunity:
            return .requestPlain
        case .joinCommunity:
            return .requestPlain
        }
    }
    
    public var headers: [String: String]? {
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
