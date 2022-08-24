//
//  TabBar+RemoteConfig.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 18.06.2022.
//

import Foundation
import RemoteConfig
import Extensions

extension TabBarViewController {
    func handleRemoteConfig() {
        let remoteConfigManager = RemoteConfigManager.shared.remoteConfig
        if remoteConfigManager.isForceUpdateEnabled && Bundle.main.buildVersion < remoteConfigManager.appVersion {
            showForceUpdate() {
                if let url = URL(string: "itms-apps://itunes.apple.com/app/id1626436370"),
                   UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
}
