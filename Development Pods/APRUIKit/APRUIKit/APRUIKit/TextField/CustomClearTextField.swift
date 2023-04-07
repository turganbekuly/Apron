//
//  CustomClearTextField.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 13.05.2022.
//

import UIKit

open class CustomClearTextField: UITextField {
    public override func layoutSubviews() {
        super.layoutSubviews()

        for view in subviews {
            if let button = view as? UIButton {
                let image = APRAssets.searchClearButton.image
                button.setImage(image, for: .normal)
                button.tintColor = .white
            }
        }
    }
}
