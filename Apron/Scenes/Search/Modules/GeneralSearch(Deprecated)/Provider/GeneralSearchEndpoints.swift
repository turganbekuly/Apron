//
//  GeneralSearchEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations

import Storages

enum GeneralSearchEndpoint {

}

extension GeneralSearchEndpoint: AKNetworkTargetType {

    var baseURL: URL {
        return URL(string: "")!
    }

    var path: String {
        return ""
    }

    var method: AKNetworkMethod {
        return .get
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