//
//  Typography.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 31.12.2021.
//

import UIKit
import Extensions

public enum Typography {

    // MARK: - Cases

    case bold24(
        text: String,
        color: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        url: URL? = nil
    )
    case semibold20(
        text: String,
        color: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        url: URL? = nil
    )
    case semibold18(
        text: String,
        color: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        url: URL? = nil
    )
    case bold16(
        text: String,
        color: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        url: URL? = nil
    )
    case medium16(
        text: String,
        color: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        url: URL? = nil
    )
    case regular20(
        text: String,
        color: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        url: URL? = nil
    )
    case regular18(
        text: String,
        color: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        url: URL? = nil
    )
    case regular16(
        text: String,
        color: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        url: URL? = nil
    )
    case regular14(
        text: String,
        color: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        url: URL? = nil
    )
    case regular12(
        text: String,
        color: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        url: URL? = nil
    )
    case regular11(
        text: String,
        color: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        url: URL? = nil
    )
    case semibold14(
        text: String,
        color: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        url: URL? = nil
    )

    public var styled: NSAttributedString {
        switch self {
        case .bold24(text: let text, color: let color, textAlignment: let textAlignment, url: let url):
            let font = TypographyFonts.bold24
            return NSAttributedString(text, color, font, textAlignment, -0.005, 32, url)
        case .semibold20(text: let text, color: let color, textAlignment: let textAlignment, url: let url):
            let font = TypographyFonts.semibold20
            return NSAttributedString(text, color, font, textAlignment, -0.005, 24, url)
        case let .semibold18(text, color, textAlignment, url):
            let font = TypographyFonts.semibold18
            return NSAttributedString(text, color, font, textAlignment, 0.025, 22, url)
        case .bold16(text: let text, color: let color, textAlignment: let textAlignment, url: let url):
            let font = TypographyFonts.bold16
            return NSAttributedString(text, color, font, textAlignment, 0, 20, url)
        case .medium16(text: let text, color: let color, textAlignment: let textAlignment, url: let url):
            let font = TypographyFonts.medium16
            return NSAttributedString(text, color, font, textAlignment, -0.025, 24, url)
        case .regular20(text: let text, color: let color, textAlignment: let textAlignment, url: let url):
            let font = TypographyFonts.regular20
            return NSAttributedString(text, color, font, textAlignment, 0.025, 24, url)
        case let .regular18(text, color, textAlignment, url):
            let font = TypographyFonts.regular18
            return NSAttributedString(text, color, font, textAlignment, 0.025, 22, url)
        case .regular16(text: let text, color: let color, textAlignment: let textAlignment, url: let url):
            let font = TypographyFonts.regular16
            return NSAttributedString(text, color, font, textAlignment, 0.025, 24, url)
        case .regular14(text: let text, color: let color, textAlignment: let textAlignment, url: let url):
            let font = TypographyFonts.regular14
            return NSAttributedString(text, color, font, textAlignment, 0, 20, url)
        case .regular12(text: let text, color: let color, textAlignment: let textAlignment, url: let url):
            let font = TypographyFonts.regular12
            return NSAttributedString(text, color, font, textAlignment, 0, 16, url)
        case .regular11(text: let text, color: let color, textAlignment: let textAlignment, url: let url):
            let font = TypographyFonts.regular12
            return NSAttributedString(text, color, font, textAlignment, 0, 14, url)
        case .semibold14(text: let text, color: let color, textAlignment: let textAlignment, url: let url):
            let font = TypographyFonts.semibold14
            return NSAttributedString(text, color, font, textAlignment, 0.025, 16, url)
        }
    }

}

