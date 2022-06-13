import Foundation

// MARK: - RemoteField

struct RemoteField {
    let defaultValue: Any
}

// MARK: - RemoteConfigDefault

public enum RemoteConfigDefault {
    static let fields: [String: RemoteField] = [
        RemoteConfigKey.isForceUpdateEnabled.rawValue: RemoteField(defaultValue: false),
        RemoteConfigKey.isMerchantListingPageFiltersEnabled.rawValue: RemoteField(defaultValue: false)
    ]
}
