//
//  MealPlannerEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Configurations
import AKNetwork
import Storages
import Models

enum MealPlannerEndpoint {
    case getRecipes(startDate: String, endDate: String)
    case saveRecipe(body: MealPlannerRequestBody)
    case deleteRecipe(body: MealPlannerRequestBody)
}

extension MealPlannerEndpoint: AKNetworkTargetType {

    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case .getRecipes, .saveRecipe, .deleteRecipe:
            return "planners"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .getRecipes:
            return .get
        case .saveRecipe:
            return .post
        case .deleteRecipe:
            return .delete
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: AKNetworkTask {
        switch self {
        case let .getRecipes(startDate, endDate):
            return .requestParameters(
                parameters: ["startDate": startDate, "endDate": endDate],
                encoding: AKURLEncoding.queryString
            )
        case let .saveRecipe(body),
            let .deleteRecipe(body):
            return .requestParameters(
                parameters: body.toJSON(),
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
