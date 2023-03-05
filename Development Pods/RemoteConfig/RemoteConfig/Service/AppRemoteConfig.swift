//
//  AppRemoteConfig.swift
//  SnoonuRemoteConfig
//
//  Created by Arman Turalin on 01.02.2023.
//

import Foundation

public protocol AppRemoteConfigProtocol: AnyObject {
    func configure(_ completion: @escaping ([String: Any]?) -> Void)
    func config<T: RemoteConfigSerializable>(for key: String, defaultValue: T?) -> T.T where T.T == T
}

public final class AppRemoteConfig {
    private let provider: ConfigProviderProtocol
    private let holder: RemoteConfigHolderProtocol

    public init(provider: ConfigProviderProtocol, holder: RemoteConfigHolderProtocol) {
        self.provider = provider
        self.holder = holder
    }
}

// MARK: - AppRemoteConfigProtocol
extension AppRemoteConfig: AppRemoteConfigProtocol {
    public func config<T: RemoteConfigSerializable>(for key: String, defaultValue: T?) -> T.T where T.T == T {
        if let value = T._remoteConfig.get(key: key, holder: holder) {
            return value
        }
        
        if let defaultValue = defaultValue {
            return defaultValue
        }
        
        fatalError("Unexpected path is executed.")
    }


    public func configure(_ completion: @escaping ([String: Any]?) -> Void) {
        provider.fetch { [weak self] config in
            self?.saveNewRemoteConfig(config)
            completion(config)
        }
    }
}

// MARK: - Private Methods
extension AppRemoteConfig {
    private func saveNewRemoteConfig(_ config: [String: Any]) {
        holder.save(remoteConfigDictionary: config)
    }
}
