import Foundation
import FirebaseRemoteConfig

public protocol RemoteConfigProviderProtocol {
    func fetchRemoteConfig(_ completion: @escaping ([String: Any]) -> Void)
}

public struct FirebaseRemoteConfigProvider: RemoteConfigProviderProtocol {
    public init() {}

    public func fetchRemoteConfig(_ completion: @escaping ([String: Any]) -> Void) {
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
