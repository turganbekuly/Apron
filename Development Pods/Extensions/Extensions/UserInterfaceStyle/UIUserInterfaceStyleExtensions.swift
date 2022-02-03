import UIKit

extension UIUserInterfaceStyle {

    public var title: String {
        switch self {
        case .light:
            return "light"
        default:
            return "dark"
        }
    }

}
