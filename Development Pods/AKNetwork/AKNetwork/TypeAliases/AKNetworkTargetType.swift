//
//  AKNetworkTargetType.swift
//  AKNetwork
//
//  Created by Akarys Turganbekuly on 07.01.2022.
//

import Moya

public protocol AKNetworkTargetType: TargetType {
    var isCancellable: Bool { get }
    var timeout: TimeInterval { get }
}

extension AKNetworkTargetType {
    public var isCancellable: Bool {
        true
    }

    public var timeout: TimeInterval {
        60
    }

}

