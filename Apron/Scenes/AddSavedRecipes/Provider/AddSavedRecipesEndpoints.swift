//
//  AddSavedRecipesEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations

import Storages

enum AddSavedRecipesEndpoint {
    case getRecipes(page: Int)
    case addToCommunity(id: Int, recipes: [Int])
}

extension AddSavedRecipesEndpoint: AKNetworkTargetType {

    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case .getRecipes:
            return "recipes/mySavedRecipes"
        case .addToCommunity:
            return "communities/addRecipesToCommunity"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .getRecipes:
            return .get
        case .addToCommunity:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: AKNetworkTask {
        switch self {
        case let .getRecipes(page):
            return .requestParameters(
                parameters: ["page": page, "limit": 20],
                encoding: AKURLEncoding.queryString
            )
        case let .addToCommunity(id, recipes):
            return .requestParameters(
                parameters: ["communityId": id, "recipeIds": recipes],
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
