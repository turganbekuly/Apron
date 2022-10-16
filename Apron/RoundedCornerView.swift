//
//  RoundedCornerView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 16.10.2022.
//

import UIKit

class RoundedCornerImageView: UIImageView {

    // if cornerRadius variable is set/changed, change the corner radius of the UIView
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

}
