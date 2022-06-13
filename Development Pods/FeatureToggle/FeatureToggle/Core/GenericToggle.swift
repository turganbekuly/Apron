import Foundation

public protocol GenericToggle: AbstractToggle {
    associatedtype ValueType: StringRepresentable

    static var defaultValue: ValueType { get }
    static var allowedValues: [ValueType] { get }
}

public extension GenericToggle {
    static var identifier: String {
        return String(describing: self)
    }

    static var defaultValueDescription: String {
        return defaultValue.rawValue
    }

    static var valueDescriptions: [String] {
        return allowedValues.map { $0.rawValue }
    }
}

public extension GenericToggle where ValueType: CaseIterable {
    static var allowedValues: ValueType.AllCases {
        return ValueType.self.allCases
    }
}

public extension GenericToggle {
    static var value: ValueType {
        return FeatureToggle.value(forToggle: self)
    }
}
