//
//  Keyboard.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.03.2023.
//

import UIKit

// swiftlint:disable notification_center_detachment

public final class Keyboard {
    public struct Notification {
        public let rect: CGRect
        public let duration: TimeInterval
    }

    public var onWillShow: ((Notification) -> Void)?
    public var onWillHide: ((Notification) -> Void)?

    public init() {
        start()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func start() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
}

private extension Keyboard {
    @objc
    func keyboardWillShow(_ notification: Foundation.Notification) {
        let notification = mapNotification(notification)
        onWillShow?(notification)
    }

    @objc
    func keyboardWillHide(_ notification: Foundation.Notification) {
        let notification = mapNotification(notification)
        onWillHide?(notification)
    }

    func mapNotification(_ notification: Foundation.Notification) -> Notification {
        var rect: CGRect = .zero
        var duration: TimeInterval = 0

        guard let userInfo = notification.userInfo else {
            return .init(rect: .zero, duration: .zero)
        }

        if let _rect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            rect = _rect
        }

        if let _duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval {
            duration = _duration
        }

        return .init(rect: rect, duration: duration)
    }
}

