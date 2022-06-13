import Foundation

public enum RemoteBoolToggleValue: String, CaseIterable, StringRepresentable {
    case disabled
    case enabled
    case remote
}

public protocol RemoteBoolToggle: GenericToggle where ValueType == RemoteBoolToggleValue { }
