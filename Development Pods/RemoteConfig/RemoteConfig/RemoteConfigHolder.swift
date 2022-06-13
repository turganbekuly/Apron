import Foundation

public protocol RemoteConfigHolderProtocol: AnyObject {
    init(persistentStorage: RemoteConfigPersistentStorage)
    func save(remoteConfigDictionary: [String: Any])

    subscript(bool key: String) -> Bool { get }
    subscript(int key: String) -> Int { get }
    subscript(string key: String) -> String { get }
}

public final class RemoteConfigHolder: RemoteConfigHolderProtocol {
    // MARK: - Dependenciees
    private let persistentStorage: RemoteConfigPersistentStorage

    // MARK: - Remote config
    private var remoteConfig: Atomic<[String: Any]>
    
    // MARK: - Init
    
    public init(persistentStorage: RemoteConfigPersistentStorage) {
        self.persistentStorage = persistentStorage
        remoteConfig = Atomic<[String: Any]>(wrappedValue:
            RemoteConfigDefault.fields.mapValues {
                $0.defaultValue
            }
        )
        guard let persistentStorageConfig = persistentStorage.remoteConfigDictionary else {
            return
        }
        forceUpdateConfig(persistentStorageConfig)
    }
    
    // MARK: - RemoteConfigHolderProtocol

    public func save(remoteConfigDictionary: [String: Any]) {
        persistentStorage.save(remoteConfigDictionary: remoteConfigDictionary)
        updateRemoteConfig(remoteConfigDictionary)
    }
    
    public subscript(bool key: String) -> Bool {
        guard let value = remoteConfig.wrappedValue[key] else {
            return false
        }

        if let stringValue = value as? String {
            if let boolValue = Bool(stringValue) {
                return boolValue
            } else if let intValue = Int(stringValue) {
                return intValue == 1
            } else {
                return false
            }
        } else if let boolValue = value as? Bool {
            return boolValue
        } else if let intValue = value as? Int {
            return intValue == 1
        } else {
            return false
        }
    }
    
    public subscript(int key: String) -> Int {
        guard let value = remoteConfig.wrappedValue[key] else {
            return 0
        }

        if let stringValue = value as? String {
            if let intValue = Int(stringValue) {
                return intValue
            } else {
                return 0
            }
        } else if let intValue = value as? Int {
            return intValue
        } else {
            return 0
        }
    }
    
    public subscript(string key: String) -> String {
        if let value = remoteConfig.wrappedValue[key] as? String {
            return value
        } else {
            return ""
        }
    }
    
    // MARK: - Helpers

    private func updateRemoteConfig(_ newConfig: [String: Any]) {
        var remoteConfig = remoteConfig.wrappedValue

        remoteConfig.keys.forEach { key in
            guard let value = newConfig[key] else {
                return
            }

            remoteConfig[key] = value
        }

        self.remoteConfig.store(newValue: remoteConfig)
    }
    
    private func forceUpdateConfig(_ newConfig: [String: Any]) {
        var config = remoteConfig.wrappedValue
        config.merge(newConfig) { $1 }
        self.remoteConfig.store(newValue: config)
    }
}

struct Atomic<Value> {
    private var value: Value
    private let lock = NSLock()

    init(wrappedValue value: Value) {
        self.value = value
    }

    var wrappedValue: Value {
      get { return load() }
      set { store(newValue: newValue) }
    }

    func load() -> Value {
        lock.lock()
        defer { lock.unlock() }
        return value
    }

    mutating func store(newValue: Value) {
        lock.lock()
        defer { lock.unlock() }
        value = newValue
    }
}

private extension Int {
    
}
