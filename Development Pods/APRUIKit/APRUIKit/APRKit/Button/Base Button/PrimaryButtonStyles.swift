//
//  PrimaryButtonStyles.swift
//  APRUIKit
//
//  Created by Akarys Turganbekuly on 12.06.2022.
//

import UIKit

struct PrimaryButtonBlackStyle: ButtonStyleProtocol {
    let button: NavigationButton

    func style() -> ButtonStyle {
        return .init(
            textColor: .init(normalColor: .white),
            font: TypographyFonts.regular14,
            background: .init(
                normalColor: .black,
                disabledColor: .black.withAlphaComponent(0.15),
                highlightedColor: .black.withAlphaComponent(0.8)
            ),
            image: nil,
            cornerRadius: .exact(15)
        )
    }
}

struct PrimaryButtonWhiteStyle: ButtonStyleProtocol {
    let button: NavigationButton

    func style() -> ButtonStyle {
        return .init(
            textColor: .init(normalColor: .black),
            font: TypographyFonts.regular14,
            background: .init(
                normalColor: .white,
                disabledColor: .white.withAlphaComponent(0.15),
                highlightedColor: .white.withAlphaComponent(0.8)
            ),
            image: nil,
            cornerRadius: .exact(15)
        )
    }
}

struct PrimaryButtonYellowStyle: ButtonStyleProtocol {
    let button: NavigationButton

    func style() -> ButtonStyle {
        return .init(
            textColor: .init(normalColor: .black),
            font: TypographyFonts.regular14,
            background: .init(
                normalColor: ApronAssets.colorsYello.color,
                disabledColor: ApronAssets.colorsYello.color.withAlphaComponent(0.5),
                highlightedColor: ApronAssets.colorsYello.color.withAlphaComponent(0.8)
            ),
            image: nil,
            cornerRadius: .exact(15)
        )
    }
}
