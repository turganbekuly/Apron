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

struct PrimaryButtonGreenStyle: ButtonStyleProtocol {
    let button: NavigationButton

    func style() -> ButtonStyle {
        return .init(
            textColor: .init(normalColor: .white),
            font: TypographyFonts.regular14,
            background: .init(
                normalColor: ApronAssets.mainAppColor.color,
                disabledColor: ApronAssets.mainAppColor.color.withAlphaComponent(0.5),
                highlightedColor: ApronAssets.mainAppColor.color.withAlphaComponent(0.8)
            ),
            image: nil,
            cornerRadius: .exact(15)
        )
    }
}

struct PrimaryButtonClearStyle: ButtonStyleProtocol {
    let button: NavigationButton

    func style() -> ButtonStyle {
        return .init(
            textColor: Button.TextColorConfig(
                normalColor: ApronAssets.primaryTextMain.color,
                disabledColor: ApronAssets.primaryTextMain.color.withAlphaComponent(0.4),
                highlightedColor: ApronAssets.primaryTextMain.color.withAlphaComponent(0.6)
            ),
            font: TypographyFonts.regular14,
            background: .init(
                normalColor: .clear,
                disabledColor: .clear,
                highlightedColor: .clear
            ),
            image: nil,
            cornerRadius: .exact(15),
            borders: Button.BorderConfig(
                width: 1,
                normalColor: ApronAssets.primaryTextMain.color.cgColor,
                disabledColor: ApronAssets.primaryTextMain.color.withAlphaComponent(0.4).cgColor,
                highlightedColor: ApronAssets.primaryTextMain.color.withAlphaComponent(0.6).cgColor
            )
        )
    }
}
