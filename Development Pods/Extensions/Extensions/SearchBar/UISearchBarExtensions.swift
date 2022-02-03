import UIKit

extension UISearchBar {

    // MARK: - Properties

    public var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            return subviews.first?.subviews.first { $0.isKind(of: UITextField.self) } as? UITextField
        }
    }

}
