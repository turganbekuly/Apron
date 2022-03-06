//
//  CGFloat+Extensions.swift
//  AKNetwork
//
//  Created by Akarys Turganbekuly on 25.02.2022.
//

import Foundation

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
