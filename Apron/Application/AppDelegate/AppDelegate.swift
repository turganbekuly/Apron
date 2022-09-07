//
//  AppDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.12.2021.
//

import UIKit
import Protocols
import Amplitude
import Storages
import AKNetwork

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    internal var window: UIWindow?

    private lazy var configurators: [ApplicationConfiguratorProtocol] = {
        [
            ThirdPartiesConfigurator(),
            InterfaceConfigurator(window: window)
        ]
    }()

    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        setupFirstRun()
        configurators.forEach { $0.configure(application, launchOptions: launchOptions) }

        return true
    }

    internal func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        guard
            userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let url = userActivity.webpageURL
        else { return false }

        DeeplinkServicesContainer.shared.deeplinkHandler.handleDeeplink(with: url)
        return true
    }

    private func setupFirstRun() {
        let defaults = UserDefaults.standard
        let isNotFirstRunKey = "isNotFirstRun"
        let isFirstRunKey = "isFirstRun"
        if defaults.bool(forKey: isNotFirstRunKey) == false && defaults.bool(forKey: isFirstRunKey) == false {
            defaults.set(true, forKey: isNotFirstRunKey)
            AuthStorage.shared.clear()
        }
    }

    @objc
    private func shouldUnauthorizeUser() {
        print("Handled")
    }
}

