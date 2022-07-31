//
//  RecipeCreationEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations
import AKNetwork
import Storages
import Models

enum RecipeCreationEndpoint {
    case createRecipe(RecipeCreation)
    case uploadImage(image: Data)
}

extension RecipeCreationEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        return Configurations.getBaseURL()
    }
    
    var path: String {
        switch self {
        case .createRecipe:
            return "recipes"
        case .uploadImage:
            return "image/upload/4"
        }
    }
    
    var method: AKNetworkMethod {
        switch self {
        case .createRecipe:
            return .post
        case .uploadImage:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: AKNetworkTask {
        switch self {
        case .createRecipe(let recipeCreation):
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
