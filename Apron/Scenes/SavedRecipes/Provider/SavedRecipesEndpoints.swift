//
//  SavedRecipesEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations
import AKNetwork
import Storages
import APRUIKit

enum SavedRecipesEndpoint {
    case getRecipes(page: Int)
}

extension SavedRecipesEndpoint: AKNetworkTargetType {

    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case .getRecipes:
            return L10n.SavedRecipes.getRecipes
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
        case let .getRecipes(page):
            return .requestParameters(
                parameters: ["page": page, "limit": 20],
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
