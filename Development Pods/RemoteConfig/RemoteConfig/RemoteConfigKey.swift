import Foundation

public enum RemoteConfigKey: String, CaseIterable {
    case isForceUpdateEnabled = "is_forceUpdateEnabled"
    case isMerchantListingPageFiltersEnabled = "is_filtersEnabled"
    case appVersion = "app_version"
}
