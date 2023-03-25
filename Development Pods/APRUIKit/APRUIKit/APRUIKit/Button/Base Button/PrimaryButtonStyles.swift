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
        let color = APRAssets.primaryTextMain.color
        return .init(
            textColor: .init(normalColor: .white),
            font: TypographyFonts.regular14,
            background: .init(
                normalColor: color,
                disabledColor: color.withAlphaComponent(0.15),
                highlightedColor: color.withAlphaComponent(0.8)
            ),
            image: nil,
            cornerRadius: .exact(15)
        )
    }
}

struct PrimaryButtonWhiteStyle: ButtonStyleProtocol {
    let button: NavigationButton

    func style() -> ButtonStyle {
        let borderColor = APRAssets.primaryTextMain.color.cgColor
        let borderDisabledColor = APRAssets.primaryTextMain.color.withAlphaComponent(0.15).cgColor
        let borderHighlightedColor = APRAssets.primaryTextMain.color.withAlphaComponent(0.8).cgColor
        return .init(
            textColor: .init(normalColor: .black),
            font: TypographyFonts.regular14,
            background: .init(
                normalColor: .white,
                disabledColor: .white.withAlphaComponent(0.15),
                highlightedColor: .white.withAlphaComponent(0.8)
            ),
            image: nil,
            cornerRadius: .exact(15),
            borders: .init(
                width: 1,
                normalColor: borderColor,
                disabledColor: borderDisabledColor,
                highlightedColor: borderHighlightedColor
            )
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
                normalColor: APRAssets.mainAppColor.color,
                disabledColor: APRAssets.mainAppColor.color.withAlphaComponent(0.5),
                highlightedColor: APRAssets.mainAppColor.color.withAlphaComponent(0.8)
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
                normalColor: APRAssets.primaryTextMain.color,
                disabledColor: APRAssets.primaryTextMain.color.withAlphaComponent(0.4),
                highlightedColor: APRAssets.primaryTextMain.color.withAlphaComponent(0.6)
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
                normalColor: APRAssets.primaryTextMain.color.cgColor,
                disabledColor: APRAssets.primaryTextMain.color.withAlphaComponent(0.4).cgColor,
                highlightedColor: APRAssets.primaryTextMain.color.withAlphaComponent(0.6).cgColor
            )
        )
    }
}

struct PrimaryButtonGrayStyle: ButtonStyleProtocol {
    let button: NavigationButton

    func style() -> ButtonStyle {
        return .init(
            textColor: .init(normalColor: APRAssets.gray.color),
            font: TypographyFonts.semibold16,
            background: .init(
                normalColor: APRAssets.lightGray2.color,
                disabledColor: APRAssets.lightGray2.color.withAlphaComponent(0.15),
                highlightedColor: APRAssets.lightGray2.color.withAlphaComponent(0.8)
            ),
            image: nil,
            cornerRadius: .exact(15)
        )
    }
}
