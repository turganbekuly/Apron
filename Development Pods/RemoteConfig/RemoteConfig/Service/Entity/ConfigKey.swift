//
//  ConfigKey.swift
//  SnoonuRemoteConfig
//
//  Created by Arman Turalin on 10.02.2023.
//

import Foundation

public struct ConfigKey<ValueType: RemoteConfigSerializable> {

    public let firebaseKey: FirebaseKeyType
    public let abKey: ABKeyType?
    public let defaultValue: ValueType.T?

    public init(firebaseKey: FirebaseKeyType, abKey: ABKeyType?, defaultValue: ValueType.T) {
        self.firebaseKey = firebaseKey
        self.abKey = abKey
        self.defaultValue = defaultValue
    }
}
