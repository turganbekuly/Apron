//
//  AuthSignUpEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations

import Storages
import Models

enum AuthSignUpEndpoint {
    case signup(body: SignUpRequest)
}

extension AuthSignUpEndpoint: AKNetworkTargetType {

    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case .signup:
            return "users"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .signup:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: AKNetworkTask {
        switch self {
        case let .signup(body):
            return .requestParameters(parameters: body.toJSON(), encoding: AKJSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        return  [
            "Accept-Language": "ru",
            "Content-Type": "application/json"
        ]
    }

}
