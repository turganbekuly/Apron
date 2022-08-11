//
//  AddCommentEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations
import AKNetwork
import Storages
import Models

enum AddCommentEndpoint {
    case rateRecipe(body: RatingRequestBody)
    case uploadImage(image: Data)
    case addComment(body: AddCommentRequestBody)
}

extension AddCommentEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        return Configurations.getBaseURL()
    }
    
    var path: String {
        switch self {
        case .rateRecipe:
            return "likes/likeToRecipe"
        case .uploadImage:
            return "image/upload/4"
        case .addComment:
            return "comments/addCommentToRecipe"
        }
    }
    
    var method: AKNetworkMethod {
        switch self {
        case .rateRecipe, .uploadImage, .addComment:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: AKNetworkTask {
        switch self {
        case let .rateRecipe(body):
            return .requestParameters(
                parameters: body.toJSON(),
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
        case let .addComment(body):
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

// MARK: - TYPES OF IMAGE UPLOAD

//switch (entityType) {
//    case 1:
//        folder = "communities";
//        break;
//    case 2:
//        folder = "product_categories";
//        break;
//    case 3:
//        folder = "products";
//        break;
//    case 4:
//        folder = "recipes";
//        break;
//    default:
//        folder = "others";
//}
