import Foundation

public enum RemoteConfigKey: String, CaseIterable {
    case isForceUpdateEnabled = "is_forceUpdateEnabled"
    case isMerchantListingPageFiltersEnabled = "is_filtersEnabled"
    case appVersion = "app_version"
    case isCookAssistantEnabled = "ios_is_cook_assistant_enabled"
}
