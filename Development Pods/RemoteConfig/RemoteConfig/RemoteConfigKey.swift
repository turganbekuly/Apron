import Foundation

public enum RemoteConfigKey: String, CaseIterable {
    case isForceUpdateEnabled = "is_forceUpdateEnabled"
    case isMerchantListingPageFiltersEnabled = "is_filtersEnabled"
    case appVersion = "app_version"
    case isCookAssistantEnabled = "ios_is_cook_assistant_enabled"
    case aboutCommunitiesLink = "about_communities_link"
    case orderFromStoreLink = "order_from_store_link"
    case contactWithDevelopersLink = "contact_with_developers_link"
    case isGallerySourceEnabled = "is_gallery_source_for_creation_enabled"
    case occasionNumber = "main_occaision_number"
    case isRecipeCreationEnabled = "ios_recipe_creation_enabled"
    case isPaidRecipeEnabled = "ios_paid_recipe_creation"
    case adBannerLink = "ios_ad_banner_link"
    case deleteAccountEnabled = "ios_delete_account_enabled"
}
