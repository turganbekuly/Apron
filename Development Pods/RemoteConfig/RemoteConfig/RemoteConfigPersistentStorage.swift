import Foundation

public protocol RemoteConfigPersistentStorage: AnyObject {
    func save(remoteConfigDictionary: [String: Any])
    var remoteConfigDictionary: [String: Any]? { get }
}
