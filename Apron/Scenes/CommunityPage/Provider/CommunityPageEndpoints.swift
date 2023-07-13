//
//  CommunityPageEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations
import Storages

enum CommunityPageEndpoint {
    case getCommunity(id: Int)
    case joinCommunity(id: Int)
    case getRecipesByCommunity(id: Int, currentPage: Int)
    case saveRecipe(id: Int)
}

extension CommunityPageEndpoint: AKNetworkTargetType {

    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case .getCommunity(let id):
            return "communities/\(id)"
        case let .joinCommunity(id):
            return "communities/join/\(id)"
        case .getRecipesByCommunity:
            return "recipes/recipesByCommunityId"
        case let .saveRecipe(id):
            return "recipes/saveRecipe/\(id)"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .getCommunity:
            return .get
        case .joinCommunity:
            return .put
        case .getRecipesByCommunity:
            return .get
        case .saveRecipe:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: AKNetworkTask {
        switch self {
        case .getCommunity:
            return .requestPlain
        case .joinCommunity:
            return .requestPlain
        case let .getRecipesByCommunity(id, currentPage):
            return .requestParameters(
                parameters: ["communityId": id, "limit": 20, "page": currentPage],
                encoding: AKURLEncoding.queryString
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
        if let token = AuthStorage.shared.accessToken {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }

}
