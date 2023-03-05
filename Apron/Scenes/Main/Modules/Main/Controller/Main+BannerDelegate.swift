//
//  Main+BannerDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.03.2023.
//

import Foundation
import RemoteConfig
import Storages

extension MainViewController: AdBannerCellProtocol {
    func adBannerTapped(with model: AdBannerObject) {
        let analyticsModel = AdBannerModel(
            username: AuthStorage.shared.isUserAuthorized ? AuthStorage.shared.username ?? "" : "guest",
            imageLink: model.bannerLink,
            actionLink: model.bannerAction
        )
        ApronAnalytics.shared.sendAnalyticsEvent(.adBannerTapped(analyticsModel))
        guard !model.bannerAction.isEmpty else { return }
        let webViewController = WebViewHandler(urlString: model.bannerAction)
        present(webViewController, animated: true)
    }
}
