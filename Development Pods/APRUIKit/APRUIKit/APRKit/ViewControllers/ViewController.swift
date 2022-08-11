//
//  ViewController.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 06.01.2022.
//

import Protocols
import UIKit

open class ViewController: UIViewController, ViewControllerProtocol {
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ApronAssets.secondary.color
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
}
