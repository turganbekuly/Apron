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
    case authByApple(code: String)
}

extension AuthorizationEndpoints: AKNetworkTargetType {

    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case .authByApple:
            return "apple/oauth2/redirect"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .authByApple:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: AKNetworkTask {
        switch self {
        case let .authByApple(code):
            return .requestParameters(
                parameters: ["code": code],
                encoding: AKURLEncoding.queryString
            )
        }
    }

    var headers: [String: String]? {
        let headers = [
            "Accept-Language": "ru",
            "Content-Type": "application/json"
        ]
        return headers
    }

}

