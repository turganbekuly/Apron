//
//  ViewControllerEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20.02.2023.
//

import Configurations

import Storages
import Models

enum ViewControllerEndpoints {
    case updateProfile(body: User)
}

extension ViewControllerEndpoints: AKNetworkTargetType {

    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case .updateProfile:
            return "users"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .updateProfile:
            return .patch
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: AKNetworkTask {
        switch self {
        case let .updateProfile(body):
            return .requestParameters(parameters: body.toJSON(), encoding: AKJSONEncoding.default)
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


