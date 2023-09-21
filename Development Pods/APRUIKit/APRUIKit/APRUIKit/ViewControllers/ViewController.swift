//
//  ViewController.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 06.01.2022.
//

import Protocols
import UIKit

open class ViewController: UIViewController, ViewControllerProtocol {
    
    open override func loadView() {
        super.loadView()
        view.backgroundColor = APRAssets.secondary.color
    }
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
}
