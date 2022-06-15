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

final class ThirdPartiesConfigurator: ApplicationConfiguratorProtocol {
    // MARK: - Methods

    func configure(_ application: UIApplication?, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        configureFirebase()
        configureAnalytics()
        configureOneSignal(launchOptions: launchOptions)
    }

    private func configureFirebase() {
        FirebaseApp.configure()
        Analytics.logEvent("test", parameters: [:])
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
}
