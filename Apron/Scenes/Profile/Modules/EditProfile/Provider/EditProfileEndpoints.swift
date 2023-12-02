//
//  EditProfileEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Configurations
import Storages
import Models

enum EditProfileEndpoint {
    case updateProfile(user: User)
    case uploadImage(image: Data)
}

extension EditProfileEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        return Configurations.getBaseURL()
    }
    
    var path: String {
        switch self {
        case .updateProfile:
            return "users"
        case .uploadImage:
            return "file/upload/image/5"
        }
    }
    
    var method: AKNetworkMethod {
        switch self {
        case .updateProfile:
            return .patch
        case .uploadImage:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: AKNetworkTask {
        switch self {
        case let .updateProfile(user):
            return .requestParameters(parameters: user.toJSON(), encoding: AKJSONEncoding.default)
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
