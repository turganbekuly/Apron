//
//  UIColor-Transform.swift
//  DohaKit
//
//  Created by Max Nechaev on 18.01.2023.
//

import Foundation
import UIKit

extension UIColor {
    private static func rgbArray(color: UIColor) -> [CGFloat] {
        var rParam: CGFloat = 0.0
        var gParam: CGFloat = 0.0
        var bParam: CGFloat = 0.0
        var alpha: CGFloat = 0.0

        if self.responds(to: #selector(getRed(_:green:blue:alpha:))) {
            color.getRed(&rParam, green: &gParam, blue: &bParam, alpha: &alpha)
        } else {
            if let components = color.cgColor.components {
                if components.count == 2 {
                    rParam = components[0]
                    gParam = components[0]
                    bParam = components[0]
                    alpha = components[1]
                } else if components.count == 4 {
                    rParam = components[0]
                    gParam = components[1]
                    bParam = components[2]
                    alpha = components[3]
                } else {
                    print("Failed to obtain color RGB")
                }
            }
        }

        return [rParam, gParam, bParam, alpha]
    }

    private static func difference(
        originColor: UIColor,
        targetColor: UIColor
    ) -> [CGFloat] {
        let originArr = self.rgbArray(color: originColor)
        let targetArr = self.rgbArray(color: targetColor)
        return [
            targetArr[0] - originArr[0],
            targetArr[1] - originArr[1],
            targetArr[2] - originArr[2],
            targetArr[3] - originArr[3]
        ]
    }

    /**
     *  Pass in two colors and proportions
     *
     *  @param originColor            Original color
     *  @param targetColor            Target color
     *  @param proportion           Between 0 and 1
     *
     *  @return UIColor
     */
    static func transform(
        originColor: UIColor,
        targetColor: UIColor,
        proportion: CGFloat
    ) -> UIColor {
        let originArr = self.rgbArray(color: originColor)
        let differenceArr = self.difference(
            originColor: originColor,
            targetColor: targetColor
        )

        return UIColor(
            red: originArr[0] + proportion * differenceArr[0],
            green: originArr[1] + proportion * differenceArr[1],
            blue: originArr[2] + proportion * differenceArr[2],
            alpha: originArr[3] + proportion * differenceArr[3]
        )
    }
}
