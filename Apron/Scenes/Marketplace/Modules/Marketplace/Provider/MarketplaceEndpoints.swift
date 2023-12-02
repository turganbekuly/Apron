//
//  MarketplaceEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Configurations
import Storages

enum MarketplaceEndpoint {
    case getProducts
}

extension MarketplaceEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        return Configurations.getBaseURL()
    }
    
    var path: String {
        switch self {
        case .getProducts:
            return "items"
        }
    }
    
    var method: AKNetworkMethod {
        switch self {
        case .getProducts:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: AKNetworkTask {
        switch self {
        case .getProducts:
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
