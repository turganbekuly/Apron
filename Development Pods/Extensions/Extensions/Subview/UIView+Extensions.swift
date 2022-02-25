//
//  UIView+Extensions.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 20.02.2022.
//

import UIKit

public extension UIView {
    @discardableResult
    func addSubviews(_ views: UIView...) -> Self {
        views.forEach { self.addSubview($0) }
        return self
    }
}
