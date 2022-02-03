import UIKit

extension UITableView {

    public func scrollToTop(animated: Bool) {
        setContentOffset(.zero, animated: animated)
    }

}
