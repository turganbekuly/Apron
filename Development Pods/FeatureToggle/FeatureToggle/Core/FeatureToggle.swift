import Foundation

public final class FeatureToggle {
    // MARK: - Private static
    private static let shared = FeatureToggle()

    // MARK: - Private properties
    private lazy var togglesStateProvider = UserDefaultsTogglesStateProvider()

    // MARK: - Init
    private init() {}

    // MARK: - Public
    public static func value<F: GenericToggle>(forToggle toggle: F.Type) -> F.ValueType {
        #if PROD
        return toggle.defaultValue
        #else
        return FeatureToggle.shared.togglesStateProvider.value(forToggle: toggle) ?? toggle.defaultValue
        #endif
    }

    // MARK: - Internal

    /// Reset toggles storage to default state.
    /// For usage in unit tests: @testable import FeatureToggle.
    public static func reset() {
        FeatureToggle.shared.togglesStateProvider.reset()
    }

    /// Set toggle value.
    /// For usage in unit tests: @testable import FeatureToggle.
    static func setValue<F: GenericToggle>(_ value: F.ValueType, forToggle toggle: F.Type) {
        FeatureToggle.shared.togglesStateProvider.setValue(value, forToggle: toggle)
    }

    // For toggles changing interface
    static func valueDescription(forToggle toggle: AbstractToggle.Type) -> String? {
        return FeatureToggle.shared.togglesStateProvider.valueDescription(forToggle: toggle)
            ?? toggle.defaultValueDescription
    }

    public static func set(valueDescription: String, forToggleIdentifier identifier: String) {
        FeatureToggle.shared.togglesStateProvider.set(
            valueDescription: valueDescription,
            forToggleIdentifier: identifier
        )
    }
}

public extension FeatureToggle {
    static func isEnabled<F: BoolToggle>(_ toggle: F.Type) -> Bool {
        return FeatureToggle.value(forToggle: toggle) == .enabled
    }

    static func setBool<F: BoolToggle>(_ value: Bool, for toggle: F.Type) {
        FeatureToggle.shared.togglesStateProvider.setValue(
            value ? BoolToggleValue.enabled : BoolToggleValue.disabled,
            forToggle: toggle
        )
    }
}
