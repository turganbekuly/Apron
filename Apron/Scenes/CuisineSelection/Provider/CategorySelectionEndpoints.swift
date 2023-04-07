//
//  CategorySelectionEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations
import AKNetwork
import Storages

enum CategorySelectionEndpoint {
    case getCategories
}

extension CategorySelectionEndpoint: AKNetworkTargetType {

    var baseURL: URL {
        return Configurations.getBaseURL()
    }

    var path: String {
        switch self {
        case .getCategories:
            return "communities/communityCategories"
        }
    }

    var method: AKNetworkMethod {
        switch self {
        case .getCategories:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: AKNetworkTask {
        return .requestPlain
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
