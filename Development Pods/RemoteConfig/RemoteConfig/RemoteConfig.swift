import Foundation
import FeatureToggle

public protocol RemoteConfigServiceProtocol: AnyObject {
    func updateConfig(completion: @escaping ([String: Any]) -> Void)
}

public protocol RemoteConfigFieldValues: AnyObject {
    var isForceUpdateEnabled: Bool { get }
    var isMerchantListingPageFiltersEnabled: Bool { get }
    var appVersion: String { get }
}

public final class RemoteConfig: RemoteConfigServiceProtocol, RemoteConfigFieldValues {
    // MARK: - Dependencies

    private let remoteConfigProvider: RemoteConfigProviderProtocol
    private let remoteConfigHolder: RemoteConfigHolderProtocol

    // MARK: - Init
    
    public init(
        remoteConfigProvider: RemoteConfigProviderProtocol = FirebaseRemoteConfigProvider(),
        remoteConfigHolder: RemoteConfigHolderProtocol = RemoteConfigHolder(persistentStorage: UserDefaultsRemoteConfigStorage())
    ) {
        self.remoteConfigProvider = remoteConfigProvider
        self.remoteConfigHolder = remoteConfigHolder
    }
    
    // MARK: - RemoteConfigServiceProtocol

    public func updateConfig(completion: @escaping ([String: Any]) -> Void = { _ in }) {
        remoteConfigProvider.fetchRemoteConfig { [weak self] config in
            self?.saveNewRemoteConfig(config)
            completion(config)
        }
    }

    // MARK: - Helpers

    private func saveNewRemoteConfig(_ config: [String: Any]){
        remoteConfigHolder.save(remoteConfigDictionary: config)
    }
}

// MARK: - RemoteConfigFieldValues

extension RemoteConfig {
    private typealias Key = RemoteConfigKey

    public var isForceUpdateEnabled: Bool {
        return remoteConfigHolder[bool: Key.isForceUpdateEnabled.rawValue]
    }

    public var isMerchantListingPageFiltersEnabled: Bool {
        let toggleValue = FeatureToggle.value(forToggle: MerchantListingPageFilters.self)

        switch toggleValue {
        case .disabled:
            return false
        case .enabled:
            return true
        case .remote:
            return remoteConfigHolder[bool: Key.isMerchantListingPageFiltersEnabled.rawValue]
        }
    }

    public var appVersion: String {
        return remoteConfigHolder[string: Key.appVersion.rawValue]
    }
}
