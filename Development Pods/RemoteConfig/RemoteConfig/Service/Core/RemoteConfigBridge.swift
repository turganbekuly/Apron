//
//  RemoteConfigBridge.swift
//  SnoonuRemoteConfig
//
//  Created by Arman Turalin on 10.02.2023.
//

import Foundation

public protocol RemoteConfigBridge {
    associatedtype T

    func get(key: String, holder: RemoteConfigHolderProtocol) -> T?
    func deserialize(_ string: String) -> T?
}

public struct RemoteConfigObjectBridge<T>: RemoteConfigBridge {
    public init() {}

    public func get(key: String, holder: RemoteConfigHolderProtocol) -> T? {
        holder.configValue(for: key) as? T
    }

    public func deserialize(_ string: String) -> T? {
        return nil
    }
}

public struct RemoteConfigArrayBridge<T: Collection>: RemoteConfigBridge {
    public init() {}

    public func get(key: String, holder: RemoteConfigHolderProtocol) -> T? {
        holder.configValue(for: key) as? T
    }

    public func deserialize(_ string: String) -> T? {
        return nil
    }
}

public struct RemoteConfigStringBridge: RemoteConfigBridge {
    public init() {}

    public func get(key: String, holder: RemoteConfigHolderProtocol) -> String? {
        holder.configValue(for: key) as? String
    }

    public func deserialize(_ string: String) -> String? {
        return nil
    }
}

public struct RemoteConfigIntBridge: RemoteConfigBridge {
    public init() {}

    public func get(key: String, holder: RemoteConfigHolderProtocol) -> Int? {
        guard let valueString = holder.configValue(for: key) as? String else { return nil }
        return Int(valueString)
    }

    public func deserialize(_ string: String) -> Int? {
        return nil
    }
}

public struct RemoteConfigDoubleBridge: RemoteConfigBridge {
    public init() {}

    public func get(key: String, holder: RemoteConfigHolderProtocol) -> Double? {
        guard let valueString = holder.configValue(for: key) as? String else { return nil }
        return Double(valueString)
    }

    public func deserialize(_ string: String) -> Double? {
        return nil
    }
}

public struct RemoteConfigBoolBridge: RemoteConfigBridge {
    public init() {}

    public func get(key: String, holder: RemoteConfigHolderProtocol) -> Bool? {
        guard let valueString = holder.configValue(for: key) as? String else { return nil }
        return valueString.contains("true")
    }

    public func deserialize(_ string: String) -> Bool? {
        return nil
    }
}

public struct RemoteConfigDataBridge: RemoteConfigBridge {
    public init() {}

    public func get(key: String, holder: RemoteConfigHolderProtocol) -> Data? {
        guard let valueString = holder.configValue(for: key) as? String else { return nil }
        return valueString.data(using: .utf8)
    }

    public func deserialize(_ string: String) -> Data? {
        return nil
    }
}

public struct RemoteConfigUrlBridge: RemoteConfigBridge {
    public init() {}

    public func get(key: String, holder: RemoteConfigHolderProtocol) -> URL? {
        guard let valueString = holder.configValue(for: key) as? String else { return nil }
        return deserialize(valueString)
    }

    public func deserialize(_ string: String) -> URL? {
        if string.isEmpty { return nil }
        if let url = URL(string: string) {
            return url
        }

        let path = (string as NSString).expandingTildeInPath
        return URL(fileURLWithPath: path)
    }
}

public struct RemoteConfigCodableBridge<T: Codable>: RemoteConfigBridge {
    public init() {}

    public func get(key: String, holder: RemoteConfigHolderProtocol) -> T? {
        guard let valueString = holder.configValue(for: key) as? String else { return nil }
        return deserialize(valueString)
    }

    public func deserialize(_ string: String) -> T? {
        guard let data = string.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
