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
    
}

extension CommunityPageEndpoint: AKNetworkTargetType {
    
    public var baseURL: URL {
        return URL(string: "")!
    }
    
    public var path: String {
        return ""
    }
    
    public var method: AKNetworkMethod {
        return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: AKNetworkTask {
        return .requestPlain
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
