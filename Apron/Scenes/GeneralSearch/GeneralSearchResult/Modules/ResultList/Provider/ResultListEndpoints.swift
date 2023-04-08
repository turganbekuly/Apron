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
            return L10n.ResultListEndpoint.GetRecipesByCommunityID.title
        case .getEverything:
            return L10n.ResultListEndpoint.GetEverything.title
        case .getSavedRecipes:
            return L10n.ResultListEndpoint.GetSavedRecipes.title
        case .getRecipes:
            return L10n.ResultListEndpoint.GetRecipes.title
        case .getCommunities:
            return L10n.ResultListEndpoint.GetCommunities.title
        case let .saveRecipe(id):
            return L10n.ResultListEndpoint.SaveRecipe.title + "\(id)"
        case let .joinCommunity(id):
            return L10n.ResultListEndpoint.JoinCommunity.title + "\(id)"
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
