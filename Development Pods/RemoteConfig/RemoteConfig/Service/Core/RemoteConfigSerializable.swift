//
//  RemoteConfigSerializable.swift
//  SnoonuRemoteConfig
//
//  Created by Arman Turalin on 10.02.2023.
//

import Foundation

public protocol RemoteConfigSerializable {
    typealias T = Bridge.T
    associatedtype Bridge: RemoteConfigBridge
    associatedtype ArrayBridge: RemoteConfigBridge

    static var _remoteConfig: Bridge { get }
    static var _remoteConfigArray: ArrayBridge { get }
}

extension RemoteConfigSerializable {
    public static var _remoteConfigArray: RemoteConfigArrayBridge<[T]> { RemoteConfigArrayBridge() }
}

extension Date: RemoteConfigSerializable {
    public static var _remoteConfig: RemoteConfigObjectBridge<Date> { RemoteConfigObjectBridge() }
}

extension String: RemoteConfigSerializable {
    public static var _remoteConfig: RemoteConfigStringBridge { RemoteConfigStringBridge() }
}

extension Int: RemoteConfigSerializable {
    public static var _remoteConfig: RemoteConfigIntBridge { RemoteConfigIntBridge() }
}

extension Double: RemoteConfigSerializable {
    public static var _remoteConfig: RemoteConfigDoubleBridge { return RemoteConfigDoubleBridge() }
}

extension Bool: RemoteConfigSerializable {
    public static var _remoteConfig: RemoteConfigBoolBridge { RemoteConfigBoolBridge() }
}

extension Data: RemoteConfigSerializable {
    public static var _remoteConfig: RemoteConfigDataBridge { RemoteConfigDataBridge() }
}

extension URL: RemoteConfigSerializable {
    public static var _remoteConfig: RemoteConfigUrlBridge { RemoteConfigUrlBridge() }
    public static var _remoteConfigArray: RemoteConfigCodableBridge<[URL]> { RemoteConfigCodableBridge() }
}

extension RemoteConfigSerializable where Self: Codable {
    public static var _remoteConfig: RemoteConfigCodableBridge<Self> { RemoteConfigCodableBridge() }
    public static var _remoteConfigArray: RemoteConfigCodableBridge<[Self]> { RemoteConfigCodableBridge() }
}

extension Dictionary: RemoteConfigSerializable where Key == String {
    public typealias T = [Key: Value]
    public typealias Bridge = RemoteConfigObjectBridge<T>
    public typealias ArrayBridge = RemoteConfigArrayBridge<[T]>

    public static var _remoteConfig: Bridge { Bridge() }
    public static var _remoteConfigArray: ArrayBridge { ArrayBridge() }
}

extension Array: RemoteConfigSerializable where Element: RemoteConfigSerializable {
    public typealias T = [Element.T]
    public typealias Bridge = Element.ArrayBridge
    public typealias ArrayBridge = RemoteConfigObjectBridge<[T]>

    public static var _remoteConfig: Bridge { Element._remoteConfigArray }
    public static var _remoteConfigArray: ArrayBridge {
        fatalError("")
    }
}
