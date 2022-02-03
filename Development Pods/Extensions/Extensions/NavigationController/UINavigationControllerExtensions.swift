import Foundation

extension UINavigationController {

    // swiftlint:disable:next override_in_extension
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }

    // swiftlint:disable:next override_in_extension
    override open var shouldAutorotate: Bool {
        false
    }

}
