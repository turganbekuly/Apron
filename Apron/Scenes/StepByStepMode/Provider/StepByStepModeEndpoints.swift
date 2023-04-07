//
//  StepByStepModeEndpoints.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24/08/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Configurations
import AKNetwork
import Storages

enum StepByStepModeEndpoint {

}

extension StepByStepModeEndpoint: AKNetworkTargetType {

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
