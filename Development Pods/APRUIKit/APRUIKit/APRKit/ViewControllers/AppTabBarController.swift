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
//            tabBar.centerButtonColor = ApronAssets.mainAppColor.color
//            if #available(iOS 13.0, *) {
//                tabBar.buttonImage = ApronAssets.tabbarAddIcon.image.withTintColor(.white, renderingMode: .alwaysTemplate)
//            } else {
//                tabBar.buttonImage = ApronAssets.tabbarAddIcon.image
//            }
//            return
//        }
        tabBar.tintColor = ApronAssets.mainAppColor.color
    }
}
