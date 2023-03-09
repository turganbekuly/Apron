//
//  ThirdPartiesConfigurator.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28.12.2021.
//

import Foundation
import Firebase
import Protocols
import Configurations
import FirebaseAnalytics
import OneSignal
import RemoteConfig
import FeatureToggle
import Wormholy
import Kingfisher
import Mixpanel
import IQKeyboardManagerSwift
import APRUIKit
import AppsFlyerLib

final class ThirdPartiesConfigurator: NSObject, ApplicationConfiguratorProtocol {
    // MARK: - Private proeprties

    var remoteConfigManager = RemoteConfigManager.shared.remoteConfig
    // MARK: - Methods

    func configure(_ application: UIApplication?, launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        configureFirebase()
        configureAnalytics()
        configureOneSignal(launchOptions: launchOptions)
        prepareFirebaseRemoteConfig()
        configureWormholy()
        configureKingfisher()
        configureIQKeyboardManager()
    }

    private func configureFirebase() {
        FirebaseApp.configure()
    }

    private func configureAnalytics() {
        AppsFlyerLib.shared().isDebug = true
        ApronAnalytics.shared.configure(
            amplitudeKey: Configurations.getAmplitudeAPIKey(),
            mixpanelKey: Configurations.getMixpanelAPIKey(),
            appsFlyerKey: Configurations.getAppsflyerDevKey(),
            appsFlyerAppId: Configurations.getAppId()
        )

        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().deepLinkDelegate = self
    }

    private func configureKingfisher() {
        ImageCache.default.diskStorage.config.sizeLimit = 1000 * 1024 * 1024
        ImageCache.default.cleanExpiredDiskCache()
    }

    private func configureOneSignal(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        OneSignal.setNotificationOpenedHandler { result in
            guard let url = URL(string: result.notification.launchURL ?? "") else { return }

            DeeplinkServicesContainer.shared.deeplinkHandler.handleDeeplink(with: url)
        }
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId(Configurations.getOneSignalAppID())
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notification: \(accepted)")
        })
    }

    private func prepareFirebaseRemoteConfig() {
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.fetchAndActivate { [weak self] _, _ in
            self?.fetchFeatureToggles()
        }
    }

    private func fetchFeatureToggles() {
        let configManager = RemoteConfigManager.shared.configManager
        configManager.forceSync {
            let test = configManager.config(for: RemoteConfigKeys.adBannerObject)
            print(test)
        }
    }

    private func configureWormholy() {
//#if DEBUG
        Wormholy.ignoredHosts = [
            "crashlytics.com",
            "googleapis.com",
            "sentry.io"
        ]
//#else
        Wormholy.shakeEnabled = false
//#endif
    }

    private func configureIQKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = ApronAssets.mainAppColor.color
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Скрыть клавиатуру"
    }
}

// MARK: - Appsflyer Deeplink

extension ThirdPartiesConfigurator: DeepLinkDelegate {
    func didResolveDeepLink(_ result: DeepLinkResult) {
        switch result.status {
        case .notFound:
            print("Deeplink not found")
        case .found:
            guard let deeplink = result.deepLink else { return }
            if deeplink.isDeferred == true {
                DeeplinkServicesContainer.shared.deeplinkHandler.handleAFDeeplink(with: deeplink)
            } else {
                DeeplinkServicesContainer.shared.deeplinkHandler.handleAFDeeplink(with: deeplink)
            }
        case .failure:
            print("Failed")
        }
    }
}

// MARK: - Appsflyer Deeplink

extension ThirdPartiesConfigurator: AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable: Any]) {
        if let data = conversionInfo as? [String: Any],
           let status = data["af_status"] as? String,
           status == "Non-organic"
        {
            DeeplinkServicesContainer.shared.deeplinkHandler.handleAFConversionDeeplink(with: conversionInfo)
        }
    }

    func onConversionDataFail(_ error: Error) {
        print(error)
    }
}
