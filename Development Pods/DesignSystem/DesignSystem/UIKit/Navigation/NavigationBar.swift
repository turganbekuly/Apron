//
//  NavigationBar.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 18.01.2022.
//

import UIKit

public class NavigationBar: UINavigationBar {
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        NavigationBar.applyLightStyle(navBar: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public static func applyLightStyle(navBar: UINavigationBar) {
        let navBarAppearance = UINavigationBarAppearance()

        UIBarButtonItem.appearance()
            .setTitleTextAttributes(
                [
                    .foregroundColor: ApronAssets.red.color,
                    .font: TypographyFonts.semibold16
                ],
                for: .normal
            )

        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .white
        navBarAppearance.shadowColor = .clear

        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: TypographyFonts.medium18
        ]
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: TypographyFonts.medium18
        ]

        var backImage: UIImage? {
            return ApronAssets.navBackButton.image
                .withInsets(UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0))?
                .withRenderingMode(.alwaysOriginal)
        }

        navBarAppearance.setBackIndicatorImage(
            backImage,
            transitionMaskImage: backImage
        )

        navBar.compactAppearance = navBarAppearance
        navBar.standardAppearance = navBarAppearance
        navBar.scrollEdgeAppearance = navBarAppearance
    }

    public static func applyTransparentStyle(navBar: UINavigationBar) {
        let navBarAppearance = UINavigationBarAppearance()

        UIBarButtonItem.appearance()
            .setTitleTextAttributes(
                [
                    .foregroundColor: ApronAssets.red.color,
                    .font: TypographyFonts.semibold16
                ],
                for: .normal
            )

        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .clear
        navBarAppearance.shadowColor = .clear
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: TypographyFonts.medium16
        ]
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: TypographyFonts.medium16
        ]

        var backImage: UIImage? {
            return ApronAssets.navBackButton.image
                .withInsets(UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0))?
                .withRenderingMode(.alwaysOriginal)
        }

        navBarAppearance.setBackIndicatorImage(
            backImage,
            transitionMaskImage: backImage
        )

        navBar.compactAppearance = navBarAppearance
        navBar.standardAppearance = navBarAppearance
        navBar.scrollEdgeAppearance = navBarAppearance
    }
}

extension UIImage {
    public func withInsets(_ insets: UIEdgeInsets) -> UIImage? {
        let newSize = CGSize(
            width: size.width + insets.left + insets.right,
            height: size.height + insets.top + insets.bottom
        )

        UIGraphicsBeginImageContextWithOptions(
            newSize,
            false,
            self.scale
        )

        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return imageWithInsets
    }
}

