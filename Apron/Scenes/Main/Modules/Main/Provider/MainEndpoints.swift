//
//  MainEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import Configurations
import AKNetwork
import Storages
import Models

enum MainEndpoint {
    case joinCommunity(id: Int)
    case getCommuntiesByCategories
    case getMyCommunities
    case getCookNowRecipes(body: SearchFilterRequestBody)
    case getEventRecipes(body: SearchFilterRequestBody)
    case saveRecipe(id: Int)
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
        case .getMyCommunities:
            return "communities/getMyCreatedCommunities/true"
        case .getCookNowRecipes, .getEventRecipes:
            return "recipes/mainSearch"
        case .saveRecipe(let id):
            return "recipes/saveRecipe/\(id)"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .joinCommunity:
            return .put
        case .getCommuntiesByCategories:
            return .get
        case .getMyCommunities:
            return .get
        case .getCookNowRecipes, .getEventRecipes:
            return .post
        case .saveRecipe:
            return .post
        }
    }

    var task: AKNetworkTask {
        switch self {
        case .joinCommunity:
            return .requestPlain
        case .getCommuntiesByCategories:
            return .requestPlain
        case .getMyCommunities:
            return .requestPlain
        case let .getCookNowRecipes(body),
            let .getEventRecipes(body):
            return .requestParameters(
                parameters: body.toJSON(),
                encoding: AKJSONEncoding.default
            )
        case .saveRecipe:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        var headers = [
            "Accept-Language": "ru",
            "Content-Type": "application/json"
        ]

        if AuthStorage.shared.isUserAuthorized {
            if let token = AuthStorage.shared.accessToken {
                headers["Authorization"] = "Bearer \(token)"
            }
        } else {
            switch self {
            case .getCommuntiesByCategories:
                break
            default:
                if let token = AuthStorage.shared.accessToken {
                    headers["Authorization"] = "Bearer \(token)"
                }
            }
        }
        return headers
    }
}
