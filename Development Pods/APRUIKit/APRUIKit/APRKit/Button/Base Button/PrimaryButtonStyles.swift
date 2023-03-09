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
        let color = ApronAssets.primaryTextMain.color
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
        let borderColor = ApronAssets.primaryTextMain.color.cgColor
        let borderDisabledColor = ApronAssets.primaryTextMain.color.withAlphaComponent(0.15).cgColor
        let borderHighlightedColor = ApronAssets.primaryTextMain.color.withAlphaComponent(0.8).cgColor
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

struct PrimaryButtonGrayStyle: ButtonStyleProtocol {
    let button: NavigationButton

    func style() -> ButtonStyle {
        return .init(
            textColor: .init(normalColor: ApronAssets.gray.color),
            font: TypographyFonts.semibold16,
            background: .init(
                normalColor: ApronAssets.lightGray2.color,
                disabledColor: ApronAssets.lightGray2.color.withAlphaComponent(0.15),
                highlightedColor: ApronAssets.lightGray2.color.withAlphaComponent(0.8)
            ),
            image: nil,
            cornerRadius: .exact(15)
        )
    }
}
