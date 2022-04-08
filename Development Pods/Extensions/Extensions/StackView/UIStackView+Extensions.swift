//
//  UIStackView+Extensions.swift
//  Extensions
//
//  Created by Akarys Turganbekuly on 17.03.2022.
//

import UIKit
import SnapKit

public extension UIStackView {
    func contains<T: UIView>(_ arrangedSubviewType: T.Type) -> Bool {
        return arrangedSubviews.contains(where: { $0 is T })
    }

    func containsArrangedSubview(where closure: (UIView) -> Bool) -> Bool {
        return arrangedSubviews.contains(where: closure)
    }

    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }

    func safeRemoveArrangedSubview(_ view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func safeRemoveArrangedSubview<T: UIView>(_ viewType: T.Type) {
        guard
            let view = arrangedSubviews
                .first(where: { $0 is T })
        else {
            return
        }

        safeRemoveArrangedSubview(view)
    }

    func removeArrangedSubview(atIndex: Int) {
        if arrangedSubviews.indices.contains(atIndex) {
            let view = arrangedSubviews[atIndex]
            safeRemoveArrangedSubview(view)
        }
    }

    func removeAllArrangedSubviews() {
        subviews.forEach { safeRemoveArrangedSubview($0) }
    }

    func addArrangedSubview(
        _ view: UIView,
        atIndex: Int,
        spacingAfter: CGFloat
    ) {
        insertArrangedSubview(view, at: atIndex)
        setCustomSpacing(spacingAfter, after: view)
    }

    func addArrangedSubview(
        _ view: UIView,
        spacingAfter: CGFloat
    ) {
        addArrangedSubview(view)
        setCustomSpacing(spacingAfter, after: view)
    }

    func addArrangedSubview(
        _ view: UIView,
        insets: UIEdgeInsets = .zero,
        spacingAfter: CGFloat? = .none
    ) {
        let wrapperView = UIView()
        wrapperView.addSubview(view)
        view.snp.matchSuperview(insets: insets, closure: nil)

        addArrangedSubview(wrapperView)

        if let spacingAfter = spacingAfter {
            setCustomSpacing(spacingAfter, after: wrapperView)
        }
    }
}

