//
//  ButtonStyleApplierProtocol.swift
//  APRUIKit
//
//  Created by Akarys Turganbekuly on 12.06.2022.
//

import UIKit

public protocol ButtonStyleApplierProtocol {}

public extension ButtonStyleApplierProtocol where Self: Button {
    init<Style: ButtonStyleProtocol>(style: Style.Type) where Style.ButtonType == Self {
        self.init()
        applyStyle(style)
    }

    @discardableResult
    func applyStyle<Style: ButtonStyleProtocol>(_ style: Style.Type) -> Self where Style.ButtonType == Self {
        let style = Style(button: self).style()
        backgroundConfig = style.background
        imageConfig = style.image
        textColorConfig = style.textColor
        cornerRadiusType = style.cornerRadius
        borderConfig = style.borders
        titleLabel?.font = style.font
        return self
    }
}

extension Button: ButtonStyleApplierProtocol {}

