//
//  AuthorizationEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.05.2022.
//

import Configurations
import AKNetwork
import Storages
import Models

enum AuthorizationEndpoints {
    case login(email: String, password: String)
}

extension AuthorizationEndpoints: AKNetworkTargetType {

    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case .login:
            return "users/login"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .login:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: AKNetworkTask {
        switch self {
        case let .login(email, password):
            return .requestParameters(
                parameters: ["email": email, "password": password],
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

