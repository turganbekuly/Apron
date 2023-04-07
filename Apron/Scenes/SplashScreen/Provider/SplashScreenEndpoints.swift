//
//  SplashScreenEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.06.2022.
//

import Configurations
import AKNetwork
import Storages
import Models

enum SplashScreenEndpoints {
    case updateToken(refreshToken: String)
}

extension SplashScreenEndpoints: AKNetworkTargetType {

    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case .updateToken:
            return "refreshToken"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .updateToken:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: AKNetworkTask {
        switch self {
        case let .updateToken(refreshToken):
            return .requestParameters(
                parameters: [
                    "refreshToken": refreshToken,
                    "grantType": AuthStorage.shared.grantType ?? ""
                ],
                encoding: AKJSONEncoding.default
            )
        }
    }

    var headers: [String: String]? {
        return [
            "Accept-Language": "ru",
            "Content-Type": "application/json"
        ]
    }

}
