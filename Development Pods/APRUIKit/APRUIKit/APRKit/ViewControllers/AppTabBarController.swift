//
//  AppTabBarController.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 12.01.2022.
//

import Protocols
import UIKit

open class AppTabBarController: UITabBarController, ViewControllerProtocol {

    // MARK: - Window

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
//        let tabBar = AppTabBar()
//        setValue(tabBar, forKey: "tabBar")
//        tabBar.centerButtonColor = Assets.colorsYello.color
//        tabBar.buttonImage = Assets.tabbarAddIcon.image
        tabBar.tintColor = .black
        self.tabBar.backgroundColor = .white
    }
}


