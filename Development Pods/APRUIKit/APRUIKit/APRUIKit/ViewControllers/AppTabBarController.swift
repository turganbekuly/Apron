//
//  AppTabBarController.swift
//  DesignSystem
//
//  Created by Akarys Turganbekuly on 12.01.2022.
//

import Protocols
import UIKit
import RemoteConfig

open class AppTabBarController: UITabBarController, ViewControllerProtocol {

    // MARK: - Window

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
//        let remoteConfigManager = RemoteConfigManager.shared.remoteConfig
//        if remoteConfigManager.isRecipeCreationEnabled {
//            let tabBar = AppTabBar()
//            setValue(tabBar, forKey: "tabBar")
//            tabBar.centerButtonColor = APRAssets.mainAppColor.color
//            if #available(iOS 13.0, *) {
//                tabBar.buttonImage = APRAssets.tabbarAddIcon.image.withTintColor(.white, renderingMode: .alwaysTemplate)
//            } else {
//                tabBar.buttonImage = APRAssets.tabbarAddIcon.image
//            }
//            return
//        }
        tabBar.tintColor = APRAssets.mainAppColor.color
    }
}
