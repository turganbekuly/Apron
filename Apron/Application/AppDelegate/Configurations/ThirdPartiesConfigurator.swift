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

final class ThirdPartiesConfigurator: ApplicationConfiguratorProtocol {
    // MARK: - Methods

    func configure(_ application: UIApplication?, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        configureFirebase()
        configureAnalytics()
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
}
