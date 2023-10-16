import Foundation
import FeatureToggle

public protocol RemoteConfigServiceProtocol: AnyObject {
    func updateConfig(completion: @escaping ([String: Any]) -> Void)
}

public protocol RemoteConfigFieldValues: AnyObject {
    var isForceUpdateEnabled: Bool { get }
    var appVersion: String { get }
    var isCookAssistantEnabled: Bool { get }
    var aboutCommunitiesLink: String { get }
    var orderFromStoreLink: String { get }
    var contactWithDevelopersLink: String { get }
    var mainOccaisionNumber: String { get }
    var isGallerySourceEnabled: Bool { get }
    var isRecipeCreationEnabled: Bool { get }
    var isPaidRecipeEnabled: Bool { get }
    var adBannerLink: String { get }
    var deleteAccountEnabled: Bool { get }
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

    private func saveNewRemoteConfig(_ config: [String: Any]) {
        remoteConfigHolder.save(remoteConfigDictionary: config)
    }
}

// MARK: - RemoteConfigFieldValues

extension RemoteConfig {
    private typealias Key = RemoteConfigKey

    public var isForceUpdateEnabled: Bool {
        return remoteConfigHolder[bool: Key.isForceUpdateEnabled.rawValue]
    }

    public var appVersion: String {
        return remoteConfigHolder[string: Key.appVersion.rawValue]
    }

    public var isCookAssistantEnabled: Bool {
        return remoteConfigHolder[bool: Key.isCookAssistantEnabled.rawValue]
    }

    public var aboutCommunitiesLink: String {
        return remoteConfigHolder[string: Key.aboutCommunitiesLink.rawValue]
    }

    public var orderFromStoreLink: String {
        return remoteConfigHolder[string: Key.orderFromStoreLink.rawValue]
    }

    public var contactWithDevelopersLink: String {
        return remoteConfigHolder[string: Key.contactWithDevelopersLink.rawValue]
    }

    public var mainOccaisionNumber: String {
        return remoteConfigHolder[string: Key.occasionNumber.rawValue]
    }

    public var isGallerySourceEnabled: Bool {
        return remoteConfigHolder[bool: Key.isGallerySourceEnabled.rawValue]
    }

    public var isRecipeCreationEnabled: Bool {
        return remoteConfigHolder[bool: Key.isRecipeCreationEnabled.rawValue]
    }

    public var isPaidRecipeEnabled: Bool {
        return remoteConfigHolder[bool: Key.isPaidRecipeEnabled.rawValue]
    }

    public var adBannerLink: String {
        return remoteConfigHolder[string: Key.adBannerLink.rawValue]
    }
    
    public var deleteAccountEnabled: Bool {
        return remoteConfigHolder[bool: Key.deleteAccountEnabled.rawValue]
    }
}
