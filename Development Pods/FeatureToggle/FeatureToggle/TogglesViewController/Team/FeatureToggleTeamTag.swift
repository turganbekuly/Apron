import UIKit

enum FeatureToggleTeamTag: String, FeatureToggleTag, CaseIterable {
    case customer
    case snoomart
    case common

    var title: String {
        switch self {
        case .customer:
            return "Customer"
        case .snoomart:
            return "Snoomart"
        case .common:
            return "Common"
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .customer:
            return UIColor(red: 217 / 255, green: 2 / 255, blue: 22 / 255, alpha: 1.0)
        case .snoomart:
            return UIColor(red: 61 / 255, green: 116 / 255, blue: 87 / 255, alpha: 1.0)
        case .common:
            return .orange
        }
    }
}
