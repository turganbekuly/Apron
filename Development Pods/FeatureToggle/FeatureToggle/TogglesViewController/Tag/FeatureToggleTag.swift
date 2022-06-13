import UIKit.UIColor

public protocol FeatureToggleTag {
    var rawValue: String { get }
    var title: String { get }
    var backgroundColor: UIColor { get }
}
