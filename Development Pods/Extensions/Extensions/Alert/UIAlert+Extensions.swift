//
//  UIAlert+Extensions.swift
//  Pods
//
//  Created by Akarys Turganbekuly on 04.09.2022.
//

import UIKit

public extension UIAlertAction {
    public var titleTextColor: UIColor? {
        get {
            return self.value(forKey: "titleTextColor") as? UIColor
        } set {
            self.setValue(newValue, forKey: "titleTextColor")
        }
    }
}
