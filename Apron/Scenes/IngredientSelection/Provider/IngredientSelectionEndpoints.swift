//
//  IngredientSelectionEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations

import Storages

enum IngredientSelectionEndpoint {
    case getProducts(query: String)
}

extension IngredientSelectionEndpoint: AKNetworkTargetType {

    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case .getProducts:
            return "products"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .getProducts:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: AKNetworkTask {
        switch self {
        case .getProducts(let query):
            return .requestParameters(
                parameters: ["name": query],
                encoding: AKURLEncoding.queryString
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
