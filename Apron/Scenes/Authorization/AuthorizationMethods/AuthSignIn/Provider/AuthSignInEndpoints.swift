//
//  AuthSignInEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations

import Storages

enum AuthSignInEndpoint {
    case login(email: String, password: String)
}

extension AuthSignInEndpoint: AKNetworkTargetType {

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
        return headers
    }
}
