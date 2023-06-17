//
//  AKNetworkTargetType.swift
//  AKNetwork
//
//  Created by Akarys Turganbekuly on 07.01.2022.
//

import Moya

protocol AKNetworkTargetType: TargetType {
    var isCancellable: Bool { get }
    var timeout: TimeInterval { get }
}

extension AKNetworkTargetType {
    var isCancellable: Bool {
        true
    }

    var timeout: TimeInterval {
        60
    }

}
