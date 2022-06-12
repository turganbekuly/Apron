//
//  ButtonStyle.swift
//  APRUIKit
//
//  Created by Akarys Turganbekuly on 12.06.2022.
//

import UIKit

public struct ButtonStyle {
    public let textColor: Button.TextColorConfig?
    public let font: UIFont?
    public let background: Button.BackgroundConfig?
    public let image: Button.ImageConfig?
    public let cornerRadius: Button.CornerRadiusType
    public let borders: Button.BorderConfig?

    public init(
        textColor: Button.TextColorConfig? = nil,
        font: UIFont? = nil,
        background: Button.BackgroundConfig? = nil,
        image: Button.ImageConfig? = nil,
        cornerRadius: Button.CornerRadiusType = .none,
        borders: Button.BorderConfig? = nil
    ) {
        self.textColor = textColor
        self.font = font
        self.background = background
        self.image = image
        self.cornerRadius = cornerRadius
        self.borders = borders
    }
}

public protocol ButtonStyleProtocol {
    associatedtype ButtonType where ButtonType: Button
    var button: ButtonType { get }
    init(button: ButtonType)
    func style() -> ButtonStyle
}
