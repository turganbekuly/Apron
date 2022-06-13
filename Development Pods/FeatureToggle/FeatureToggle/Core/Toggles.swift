// swiftlint:disable:this file_name
import Foundation

struct TogglesStorage {
    // Список всех тоглов для отображения в меню дебага
    static let allToggles: [AbstractToggle.Type] = [
        MerchantListingPageFilters.self,
    ]
}

// MARK: - Toggles

public struct MerchantListingPageFilters: RemoteBoolToggle {
    public static let description = "MerchantListingPageFilters"
    public static let defaultValue = RemoteBoolToggleValue.remote
    public static let tags: [FeatureToggleTag] = [FeatureToggleTeamTag.customer]
}
