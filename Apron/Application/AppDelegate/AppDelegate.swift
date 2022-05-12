//
//  AppDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.12.2021.
//

import UIKit
import Protocols
import Amplitude

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    internal var window: UIWindow?

    private lazy var configurators: [ApplicationConfiguratorProtocol] = {
        [
            ThirdPartiesConfigurator(),
            InterfaceConfigurator(window: window)
        ]
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        configurators.forEach { $0.configure(application, launchOptions: launchOptions) }
        return true
    }
}

