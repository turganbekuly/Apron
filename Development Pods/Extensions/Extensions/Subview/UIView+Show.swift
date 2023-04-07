//
//  UIView+Show.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 20.02.2022.
//

import UIKit

extension Collection where Element: UIView {
    func show(_ isShow: Bool, duration: TimeInterval, completion: (() -> Void)? = nil) {
        if isShow {
            self.forEach { $0.isHidden = false }
            UIView.animate(
                withDuration: duration,
                animations: {
                    self.forEach { $0.alpha = 1.0 }
                }, completion: { _ in
                    completion?()
                }
            )
        } else {
            UIView.animate(
                withDuration: duration,
                animations: {
                    self.forEach { $0.alpha = 0.0 }
                },
                completion: { _ in
                    self.forEach { $0.isHidden = true }
                    completion?()
                }
            )
        }
    }
}

extension UIView {
    func show(_ isShow: Bool, duration: TimeInterval, completion: (() -> Void)? = nil) {
        if isShow {
            isHidden = false

            if duration <= 0.0 {
                self.alpha = 1.0
                completion?()
            } else {
                UIView.animate(
                    withDuration: duration,
                    animations: {
                        self.alpha = 1.0
                    }, completion: { _ in
                        completion?()
                    }
                )
            }
        } else {
            if duration <= 0.0 {
                self.alpha = 0.0
                self.isHidden = true
                completion?()
            } else {
                UIView.animate(
                    withDuration: duration,
                    animations: {
                        self.alpha = 0.0
                    },
                    completion: { _ in
                        self.isHidden = true
                        completion?()
                    }
                )
            }
        }
    }
}
