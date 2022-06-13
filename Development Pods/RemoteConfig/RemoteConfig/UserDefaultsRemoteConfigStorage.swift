import Foundation

public final class UserDefaultsRemoteConfigStorage: RemoteConfigPersistentStorage {
    // MARK: - Private properties

    private let userDefaultKey = "remoteConfig_config"

    // MARK: - Init

    public init() {}
    
    // MARK: - RemoteConfigPersistentStorage
    public func save(remoteConfigDictionary: [String: Any]) {
        let dictionaryToSave = remoteConfigDictionary.filter { !($0.value is NSNull) }
        UserDefaults.standard.set(dictionaryToSave, forKey: userDefaultKey)
    }
    
    public var remoteConfigDictionary: [String: Any]? {
        return UserDefaults.standard.dictionary(forKey: userDefaultKey)
    }
    
}
