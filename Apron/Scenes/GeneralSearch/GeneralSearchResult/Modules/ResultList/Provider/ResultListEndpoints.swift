//
//  ResultListEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations
import AKNetwork
import Storages
import Models

enum ResultListEndpoint {
    case getRecipesByCommunityID(RecipesByCommunityIDRequestBody)
}

extension ResultListEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        return Configurations.getBaseURL()
    }
    
    var path: String {
        switch self {
        case .getRecipesByCommunityID:
            return "recipes/recipesByCommunityId"
        }
    }
    
    var method: AKNetworkMethod {
        switch self {
        case .getRecipesByCommunityID:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: AKNetworkTask {
        switch self {
        case let .getRecipesByCommunityID(requestBody):
            return .requestParameters(
                parameters: [
                    "communityId": requestBody.id,
                    "limit": 20,
                    "page": requestBody.currentPage,
                    "name": requestBody.query
                ],
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
