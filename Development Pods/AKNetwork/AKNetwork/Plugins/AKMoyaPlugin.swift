//
//  AKMoyaPlugin.swift
//  Alamofire
//
//  Created by Akarys Turganbekuly on 07.01.2022.
//

import Foundation
import Moya

public struct AKMoyaPlugin: PluginType {

    // MARK: - Methods

    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let mcTarget = target as? AKNetworkTargetType else { return request }

        var mcRequest = request
        mcRequest.timeoutInterval = mcTarget.timeout
        return mcRequest
    }

}

