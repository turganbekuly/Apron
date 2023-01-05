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
import FirebaseDynamicLinks
import AppTrackingTransparency
import AppsFlyerLib

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private lazy var configurators: [ApplicationConfiguratorProtocol] = {
        [
            ThirdPartiesConfigurator(),
            InterfaceConfigurator(window: window)
        ]
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        setupFirstRun()
        AppsFlyerLib.shared().deepLinkDelegate = self
        configurators.forEach { $0.configure(application, launchOptions: launchOptions) }

        return true
    }

    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url),
           let dynamicURL = dynamicLink.url
        {
            DeeplinkServicesContainer.shared.deeplinkHandler.handleDeeplink(with: dynamicURL)
            return true
        }
        DeeplinkServicesContainer.shared.deeplinkHandler.handleDeeplink(with: url)
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        let user = AuthStorage.shared
        AppsFlyerLib.shared().start()
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 120)
        AppsFlyerLib.shared().customData = ["id": 0, "name": user.username ?? "", "email": user.email ?? ""]
        requestTrackingAuthorization()
    }

    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        guard
            userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let url = userActivity.webpageURL
        else { return false }
        AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
        let linkHandled = DynamicLinks.dynamicLinks().handleUniversalLink(url) { dynamicLink, error in
            guard error == nil else { return }

            if let dynamicLink = dynamicLink,
               let dynamicURL = dynamicLink.url {
                DeeplinkServicesContainer.shared.deeplinkHandler.handleDeeplink(with: dynamicURL)
            }
        }
        if linkHandled { return true }

        DeeplinkServicesContainer.shared.deeplinkHandler.handleDeeplink(with: url)
        return true
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        #if DEBUG
        AppsFlyerLib.shared().useUninstallSandbox = true
        #endif

        AppsFlyerLib.shared().registerUninstall(deviceToken)
    }

    @objc func requestTrackingAuthorization() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { (status) in
                switch status {
                case .denied:
                    print("AuthorizationSatus is denied")
                case .notDetermined:
                    print("AuthorizationSatus is notDetermined")
                case .restricted:
                    print("AuthorizationSatus is restricted")
                case .authorized:
                    print("AuthorizationSatus is authorized")
                @unknown default:
                    fatalError("Invalid authorization status")
                }
            }
        }
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
}

extension AppDelegate: DeepLinkDelegate {
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

extension AppDelegate: AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        if let status = conversionInfo["af_status"] as? String {
            if (status == "Non-organic") {
                // Business logic for Non-organic install scenario is invoked
                if let sourceID = conversionInfo["media_source"],
                   let campaign = conversionInfo["campaign"] {
                    print("This is a Non-organic install. Media source: \(sourceID)  Campaign: \(campaign)")
                }
            }
            else {
                // Business logic for organic install scenario is invoked
            }
        }
    }

    func onConversionDataFail(_ error: Error) {
        print(error)
    }
}
