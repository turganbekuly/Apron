import Foundation

public enum BoolToggleValue: String, CaseIterable, StringRepresentable {
    case disabled, enabled
}

public protocol BoolToggle: GenericToggle where ValueType == BoolToggleValue {
}

public extension BoolToggle {
    static var isEnabled: Bool {
        FeatureToggle.isEnabled(self)
    }
}
