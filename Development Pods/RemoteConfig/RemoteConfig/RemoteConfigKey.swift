import Foundation

public enum RemoteConfigKey: String, CaseIterable {
    case isForceUpdateEnabled = "is_forceUpdateEnabled"
    case isMerchantListingPageFiltersEnabled = "is_filtersEnabled"
    case appVersion = "app_version"
    case isCookAssistantEnabled = "ios_is_cook_assistant_enabled"
    case aboutCommunitiesLink = "about_communities_link"
    case orderFromStoreLink = "order_from_store_link"
    case contactWithDevelopersLink = "contact_with_developers_link"
}
