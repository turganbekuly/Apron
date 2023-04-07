import Foundation

final class UserDefaultsTogglesStateProvider {
    // MARK: - Private properties

    private let userDefaults = UserDefaults.standard
    private let userDefaultsKey = "com.apron.feature-toggles"
    private let syncQueue = DispatchQueue(label: "com.apron.UserDefaultsTogglesStateProvider")
    private var togglesCache: [String: String]

    // MARK: - Init

    init() {
        togglesCache = userDefaults.value(forKey: userDefaultsKey) as? [String: String] ?? [:]
    }

    // MARK: - Internal methods

    func value<F: GenericToggle>(forToggle toggle: F.Type) -> F.ValueType? {
        return syncQueue.sync {
            if let cachedValue = togglesCache[toggle.identifier] {
                return F.ValueType(rawValue: cachedValue)
            }
            return nil
        }
    }

    // For usage from tests
    func setValue<F: GenericToggle>(_ value: F.ValueType, forToggle toggle: F.Type) {
        syncQueue.async {
            self.togglesCache[toggle.identifier] = value.rawValue
            self.synchronize()
        }
    }

    // For toggles changing interface
    func valueDescription(forToggle toggle: AbstractToggle.Type) -> String? {
        return syncQueue.sync {
            togglesCache[toggle.identifier]
        }
    }

    func set(valueDescription: String, forToggleIdentifier identifier: String) {
        syncQueue.async {
            self.togglesCache[identifier] = valueDescription
            self.synchronize()
        }
    }

    func reset() {
        syncQueue.async {
            self.togglesCache.removeAll()
            self.synchronize()
        }

    }

    // MARK: - Private methods

    private func synchronize() {
        userDefaults.setValue(togglesCache, forKey: userDefaultsKey)
        userDefaults.synchronize()
    }
}
