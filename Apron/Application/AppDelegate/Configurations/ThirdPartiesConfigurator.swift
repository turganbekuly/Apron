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

final class ThirdPartiesConfigurator: ApplicationConfiguratorProtocol {
    // MARK: - Private proeprties

    var remoteConfigManager = RemoteConfigManager.shared.remoteConfig
    // MARK: - Methods

    func configure(_ application: UIApplication?, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        configureFirebase()
        configureAnalytics()
        configureOneSignal(launchOptions: launchOptions)
    }

    private func configureFirebase() {
        FirebaseApp.configure()
    }

    private func configureAnalytics() {
        ApronAnalytics.shared.configure(
            amplitudeKey: Configurations.getAmplitudeAPIKey(),
            appsflyerDevKey: "",
            appleAppID: ""
        )
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
            self?.remoteConfigManager.updateConfig { toggles in
                var config: [String: String] = [:]
                toggles.forEach { config[$0.key] = "\($0.value)" }
            }
        }
    }
}
