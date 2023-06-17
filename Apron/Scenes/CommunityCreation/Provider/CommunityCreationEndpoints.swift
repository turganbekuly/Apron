//
//  CommunityCreationEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations

import Storages
import Models
import UIKit

enum CommunityCreationEndpoint {
    case communityCreation(CommunityCreation)
    case uploadImage(image: Data)
}

extension CommunityCreationEndpoint: AKNetworkTargetType {

    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case .communityCreation:
            return "communities"
        case .uploadImage:
            return "file/upload/image/1"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .communityCreation:
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
        case .communityCreation(let communityCreation):
            return .requestParameters(
                parameters: communityCreation.toJSON(),
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
