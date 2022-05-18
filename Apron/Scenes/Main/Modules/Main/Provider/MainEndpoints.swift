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
    case getCommuntiesByCategories
}

extension MainEndpoint: AKNetworkTargetType {
    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case let .joinCommunity(id):
            return "communities/join/\(id)"
        case .getCommuntiesByCategories:
            return "communities/main"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .joinCommunity:
            return .put
        case .getCommuntiesByCategories:
            return .get
        }
    }

    var task: AKNetworkTask {
        switch self {
        case .joinCommunity:
            return .requestPlain
        case .getCommuntiesByCategories:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        var headers = [
            "Accept-Language": "ru",
            "Content-Type": "application/json"
        ]
        switch self {
        case .getCommuntiesByCategories:
            break
        default:
            if let token = AuthStorage.shared.accessToken {
                headers["Authorization"] = "Bearer \(token)"
            }
        }
        return headers
    }
}
