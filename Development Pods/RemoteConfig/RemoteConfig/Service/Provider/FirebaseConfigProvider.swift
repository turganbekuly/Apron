//
//  FirebaseConfigProvider.swift
//  SnoonuRemoteConfig
//
//  Created by Arman Turalin on 04.02.2023.
//

import Foundation
import FirebaseRemoteConfig

public struct FirebaseConfigProvider {
    public init() {}
}

// MARK: - ConfigProviderProtocol
extension FirebaseConfigProvider: ConfigProviderProtocol {
    public func fetch(_ completion: @escaping ([String: Any]) -> Void) {
        let remoteConfig = FirebaseRemoteConfig.RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        let keys = remoteConfig.allKeys(from: .remote)
        var config: [String: String] = [:]
        keys.forEach { config[$0] = remoteConfig[$0].stringValue }
        completion(config)
    }
}
