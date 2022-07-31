//
//  Messagable.swift
//  AlertMessages
//
//  Created by Akarys Turganbekuly on 13.01.2022.
//

import HapticTouch
import APRUIKit
import SwiftEntryKit
import UIKit

public protocol Messagable: AnyObject {
    func show(type: MessageType, firstAction: (() -> Void)?, secondAction: (() -> Void)?)
    func showLoader()
    func hideLoader()
}

@available(iOS 13.0, *)
extension Messagable where Self: UIViewController {

    public func show(type: MessageType, firstAction: (() -> Void)? = nil, secondAction: (() -> Void)? = nil) {
        guard !SwiftEntryKit.isCurrentlyDisplaying(entryNamed: type.name) else { return }

        let messageView = MessageView(type: type)
        messageView.didTappedFirstButton = { [weak self] in
            firstAction?()
            self?.hideLoader()
        }
        messageView.didTappedSecondButton = { [weak self] in
            secondAction?()
            self?.hideLoader()
        }

        configure(messageView: messageView, with: type)
        show(messageView: messageView, for: type)
    }

    public func showForceUpdate(type: MessageType = .forceUpdate, updateButton: (() -> Void)? = nil) {
        guard !SwiftEntryKit.isCurrentlyDisplaying(entryNamed: type.name) else { return }

        let messageView = MessageView(type: type)
        messageView.didTappedFirstButton = { [weak self] in
            updateButton?()
        }

        configure(messageView: messageView, with: type)
        show(messageView: messageView, for: type)
    }

    public func showLoader() {
        show(type: .loader)
    }

    public func hideLoader() {
        SwiftEntryKit.dismiss()
    }

    private func configure(messageView: MessageView, with type: MessageType) {
        switch type {
        case let .success(title):
            messageView.configure(with: SuccessMessageViewModel(title: title))
        case let .dialog(title, subtitle, firstButtonTitle, secondButtonTitle):
            messageView.configure(with: DialogMessageViewModel(
                title: title,
                subtitle: subtitle,
                firstButtonTitle: firstButtonTitle,
                secondButtonTitle: secondButtonTitle
            ))
        case .forceUpdate:
            messageView.configure(with: ForceUpdateMessageViewModel())
        case let .error(title):
            messageView.configure(with: ErrorMessageViewModel(title: title))
        case let .regular(title, firstButtonTitle):
            messageView.configure(with: RegularMessageViewModel(title: title, firstButtonTitleText: firstButtonTitle))
        case .loader:
            messageView.configure(with: LoaderMessageViewModel())
        }
    }

    private func show(messageView: MessageView, for type: MessageType) {
        var widthConstraint: EKAttributes.PositionConstraints.Edge {
            switch type {
            case .loader:
                return .constant(value: 100)
            default:
                return .offset(value: 8)
            }
        }
        var heightConstraint: EKAttributes.PositionConstraints.Edge {
            switch type {
            case .loader:
                return .constant(value: 100)
            default:
                return .intrinsic
            }
        }
        var attributes = EKAttributes()
        attributes.name = type.name
        attributes.positionConstraints.size = .init(width: widthConstraint, height: heightConstraint)
        attributes.positionConstraints.rotation.isEnabled = false
        attributes.statusBar = getStatusBar()
        switch type {
        case .dialog:
            attributes.displayDuration = .infinity
            attributes.entryInteraction = .absorbTouches
            attributes.position = .bottom
            attributes.positionConstraints.verticalOffset = 64
        case .success, .regular:
            attributes.displayDuration = 5
            attributes.position = .bottom
            HapticTouch.generateSuccess()
        case .error:
            attributes.displayDuration = 3
            attributes.position = .bottom
            HapticTouch.generateError()
        case .loader:
            attributes.displayDuration = .infinity
            attributes.entranceAnimation = .init(fade: .some(.init(from: 0, to: 1, duration: 0.3)))
            attributes.entryInteraction = .absorbTouches
            attributes.exitAnimation = .init(fade: .some(.init(from: 1, to: 0, duration: 0.3)))
            attributes.position = .center
            attributes.screenBackground = .color(color: .black.with(alpha: 0.5))
            attributes.screenInteraction = .absorbTouches
            attributes.scroll = .disabled
            messageView.animationView.play()
        case .forceUpdate:
            attributes.displayDuration = .infinity
            attributes.entranceAnimation = .init(fade: .some(.init(from: 0, to: 1, duration: 0.3)))
            attributes.entryInteraction = .absorbTouches
            attributes.exitAnimation = .init(fade: .some(.init(from: 1, to: 0, duration: 0.3)))
            attributes.position = .center
            attributes.screenBackground = .color(color: .black.with(alpha: 0.7))
            attributes.screenInteraction = .absorbTouches
            attributes.scroll = .disabled
            HapticTouch.generateError()
        }
        SwiftEntryKit.display(entry: messageView, using: attributes)
    }

    private func getStatusBar() -> EKAttributes.StatusBar {
        if #available(iOS 13.0, *) {
            if let userInterfaceStyle = UIApplication.shared.windows.first?.overrideUserInterfaceStyle {
                switch userInterfaceStyle {
                case .unspecified:
                    return .inferred
                case .light:
                    return .dark
                case .dark:
                    return .light
                }
            }
        }
        return .inferred
    }

}

