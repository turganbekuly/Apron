//
//  SearchByIngredientsEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Configurations
import Storages

enum SearchByIngredientsEndpoint {
    case getSuggestedProducts(ids: [Int])
    case getProducts(name: String)
}

extension SearchByIngredientsEndpoint: AKNetworkTargetType {
    
    var baseURL: URL {
        Configurations.getBaseURL()
    }
    
    var path: String {
        switch self {
        case .getSuggestedProducts:
            return "products/getProductsByIds"
        case .getProducts:
            return "products"
        }
    }
    
    var method: AKNetworkMethod {
        switch self {
        case .getSuggestedProducts:
            return .post
        case .getProducts:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: AKNetworkTask {
        switch self {
        case let .getSuggestedProducts(ids):
            let body = ["ids": ids]
            return .requestParameters(parameters: body, encoding: AKJSONEncoding.default)
        case let .getProducts(name):
            let body = ["name": name]
            return .requestParameters(parameters: body, encoding: AKURLEncoding.queryString)
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
