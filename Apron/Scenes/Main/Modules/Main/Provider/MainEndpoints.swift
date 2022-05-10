//
//  MainEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import Configurations
import AKNetwork
import Storages

enum MainEndpoint {
    case joinCommunity(id: Int)
}

extension MainEndpoint: AKNetworkTargetType {
    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case let .joinCommunity(id):
            return "communities/join/\(id)"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .joinCommunity:
            return .put
        }
    }

    var task: AKNetworkTask {
        switch self {
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
