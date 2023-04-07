import Foundation
import UIKit

/// A struct holding all keyboard view information when it's being shown or hidden.
public struct MCKeyboardAppearanceInfo {

    // MARK: - Properties

    public let notification: Notification
    public let userInfo: [AnyHashable: Any]

    public var beginFrame: CGRect {
        (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
    }

    public var endFrame: CGRect {
        (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
    }

    public var belongsToCurrentApp: Bool {
        (userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? Bool) ?? true
    }

    public var animationDuration: Double {
        (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
    }

    public var animationCurve: UIView.AnimationCurve {
        guard let value = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int else { return .easeInOut }
        return UIView.AnimationCurve(rawValue: value) ?? .easeInOut
    }

    public var animationOptions: UIView.AnimationOptions {
        UIView.AnimationOptions(rawValue: UInt(animationCurve.rawValue << 16))
    }

    // MARK: - Init

    public init(notification: Notification) {
        self.notification = notification
        userInfo = notification.userInfo ?? [:]
    }

    // MARK: - Methods

    public func animateAlong(
        _ animationBlock: @escaping (() -> Void),
        completion: @escaping ((_ finished: Bool) -> Void) = { _ in }
    ) {
        UIView.animate(
            withDuration: animationDuration,
            delay: 0.0,
            options: animationOptions,
            animations: animationBlock,
            completion: completion
        )
    }

}
