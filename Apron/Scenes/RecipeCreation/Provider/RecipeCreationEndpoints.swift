//
//  RecipeCreationEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations

import Storages
import Models

enum RecipeCreationEndpoint {
    case createRecipe(RecipeCreation)
    case editRecipe(RecipeCreation)
    case uploadImage(image: Data)
}

extension RecipeCreationEndpoint: AKNetworkTargetType {

    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case .createRecipe, .editRecipe:
            return "recipes"
        case .uploadImage:
            return "file/upload/image/4"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .createRecipe:
            return .post
        case .editRecipe:
            return .put
        case .uploadImage:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: AKNetworkTask {
        switch self {
        case let .createRecipe(recipeCreation),
            let .editRecipe(recipeCreation):
            return .requestParameters(
                parameters: recipeCreation.toJSON(),
                encoding: AKJSONEncoding.default
            )
        case let .uploadImage(data):
            return .uploadMultipart(
                [
                    .init(
                        provider: .data(data),
                        name: "file",
                        fileName: "image.jpg",
                        mimeType: "image/jpeg"
                    )
                ]
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
