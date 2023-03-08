//
//  RecipePageEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations
import AKNetwork
import Storages
import Models

enum RecipePageEndpoint {
    case getRecipe(id: Int)
    case rateRecipe(body: RatingRequestBody)
    case saveRecipe(id: Int)
    case getCommentsByRecipe(id: Int)
}

extension RecipePageEndpoint: AKNetworkTargetType {

    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case .getRecipe(let id):
            return "recipes/\(id)"
        case .rateRecipe:
            return "likes/likeToRecipe"
        case let .saveRecipe(id):
            return "recipes/saveRecipe/\(id)"
        case .getCommentsByRecipe:
            return "comments/getCommentsByRecipeId"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .getRecipe:
            return .get
        case .rateRecipe:
            return .post
        case .saveRecipe:
            return .post
        case .getCommentsByRecipe:
            return .get
        }
    }

    var task: AKNetworkTask {
        switch self {
        case .getRecipe:
            return .requestPlain
        case let .rateRecipe(body):
            return .requestParameters(
                parameters: body.toJSON(),
                encoding: AKJSONEncoding.default
            )
        case .saveRecipe:
            return .requestPlain
        case let .getCommentsByRecipe(id):
            return .requestParameters(
                parameters: ["recipeId": id],
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
