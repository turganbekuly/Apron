//
//  ConfigurationManager.swift
//  SnoonuRemoteConfig
//
//  Created by Arman Turalin on 04.02.2023.
//

import Foundation

public protocol ConfigurationManagerProtocol {
    func forceSync(completion: @escaping () -> Void)
    func config<T: RemoteConfigSerializable>(for key: ConfigKey<T>) -> T.T where T.T == T
}

public final class ConfigurationManager {
    let firebaseRemoteConfig: AppRemoteConfigProtocol
//    let abRemoteConfig: AppRemoteConfigProtocol

    private var featureConfigHandlers: [FeatureConfigHandler] = []

    public init(
        firebaseRemoteConfig: AppRemoteConfigProtocol//,
//        abRemoteConfig: AppRemoteConfigProtocol
    ) {
        self.firebaseRemoteConfig = firebaseRemoteConfig
//        self.abRemoteConfig = abRemoteConfig
        self.featureConfigHandlers = FeatureConfigHandlerFactory.createFeatureConfigHandlers(self)
    }
}

// MARK: - ConfigurationManagerProtocol
extension ConfigurationManager: ConfigurationManagerProtocol {
    public func forceSync(completion: @escaping () -> Void) {
        firebaseRemoteConfig.configure { toggles in
            var config: [String: String] = [:]
            toggles?.forEach { config[$0.key] = "\($0.value)" }
            completion()
        }
//        abRemoteConfig.configure { toggles in
//            var config: [String: String] = [:]
//            toggles?.forEach { config[$0.key] = "\($0.value)" }
//        }
    }
        
    public func config<T: RemoteConfigSerializable>(for key: ConfigKey<T>) -> T.T where T.T == T {
        let handler = featureConfigHandlers.first(where: { $0.firebaseKey == key.firebaseKey })
        
        guard let handler = handler else {
            return firebaseRemoteConfig.config(
                for: key.firebaseKey.rawValue,
                defaultValue: key.defaultValue
            )
        }
        
        return handler.config(for: key)
    }
}

// MARK: - Private methods
extension ConfigurationManager {
}
