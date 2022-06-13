import Foundation

public protocol StringRepresentable {
    init?(rawValue: String)
    var rawValue: String { get }
}

public protocol AbstractToggle {
    static var identifier: String { get }
    static var description: String { get }

    static var defaultValueDescription: String { get }
    static var valueDescriptions: [String] { get }

    static var tags: [FeatureToggleTag] { get }
    
}
