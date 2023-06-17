//
//  ResultListEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations

import Storages
import Models
import APRUIKit

enum ResultListEndpoint {
    case getRecipesByCommunityID(RecipesByCommunityIDRequestBody)
    case getEverything(query: String)
    case getSavedRecipes(SearchByQueryRequestBody)
    case getRecipes(SearchByQueryRequestBody)
    case getCommunities(SearchByQueryRequestBody)
    case saveRecipe(id: Int)
    case joinCommunity(id: Int)
}

extension ResultListEndpoint: AKNetworkTargetType {

    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case .getRecipesByCommunityID:
            return "recipes/recipesByCommunityId"
        case .getEverything:
            return "recipes/searchByRecipesAndCommunities"
        case .getSavedRecipes:
            return "recipes/mySavedRecipes"
        case .getRecipes:
            return "recipes"
        case .getCommunities:
            return "communities"
        case let .saveRecipe(id):
            return "recipes/saveRecipe/\(id)"
        case let .joinCommunity(id):
            return "communities/join/\(id)"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .getRecipesByCommunityID,
                .getEverything,
                .getSavedRecipes,
                .getRecipes,
                .getCommunities:
            return .get
        case .saveRecipe:
            return .post
        case .joinCommunity:
            return .put
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
                    "name": "\(requestBody.query)"
                ],
                encoding: AKURLEncoding.queryString
            )
        case let .getEverything(query):
            return .requestParameters(
                parameters: ["name": query],
                encoding: AKURLEncoding.queryString
            )
        case let .getSavedRecipes(body):
            return .requestParameters(
                parameters: body.toJSON(),
                encoding: AKURLEncoding.queryString
            )
        case let .getRecipes(body):
            return .requestParameters(
                parameters: body.toJSON(),
                encoding: AKURLEncoding.queryString
            )
        case let .getCommunities(body):
            return .requestParameters(
                parameters: body.toJSON(),
                encoding: AKURLEncoding.queryString
            )
        case .saveRecipe, .joinCommunity:
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
