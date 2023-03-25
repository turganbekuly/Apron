import Foundation
import UIKit

public protocol MCKeyboardHelperDelegate: AnyObject {
    func keyboardWillAppear(_ info: MCKeyboardAppearanceInfo)
    func keyboardWillDisappear(_ info: MCKeyboardAppearanceInfo)
}

extension MCKeyboardHelperDelegate {
    public func keyboardWillAppear(_: MCKeyboardAppearanceInfo) {}
    public func keyboardWillDisappear(_: MCKeyboardAppearanceInfo) {}
}

public final class MCKeyboardHelper {

    // MARK: - Properties

    public weak var delegate: MCKeyboardHelperDelegate?

    // MARK: - Init

    public required init(delegate: MCKeyboardHelperDelegate) {
        self.delegate = delegate

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(MCKeyboardHelper.keyboardWillAppear(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(MCKeyboardHelper.keyboardWillDisappear(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private init() {
        delegate = nil
    }

    // MARK: - Methods

    @objc
    private dynamic func keyboardWillAppear(_ note: Notification) {
        let info = MCKeyboardAppearanceInfo(notification: note)
        delegate?.keyboardWillAppear(info)
    }

    @objc
    private dynamic func keyboardWillDisappear(_ note: Notification) {
        let info = MCKeyboardAppearanceInfo(notification: note)
        delegate?.keyboardWillDisappear(info)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
