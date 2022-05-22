//
//  InterfaceConfigurator.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28.12.2021.
//

import Foundation
import Protocols
import Models
import Storages

final class InterfaceConfigurator: ApplicationConfiguratorProtocol {
    // MARK: - Properties

    private var window: UIWindow?

    // MARK: - Init

    init(window: UIWindow?) {
        self.window = window
    }

    // MARK: - Methods

    func configure(_ application: UIApplication?, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        guard let window = window else {
            fatalError("Window not found")
        }
        
        let vc = SplashScreenBuilder(state: .initial).build()
//        let vc = AuthorizationBuilder(state: .initial).build()
        AuthStorage.shared.isUserAuthorized = true
        AuthStorage.shared.accessToken = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkaW5hc2lsLm9tYXJiZWtAZ21haWwuY29tIiwiZXhwIjoxNjUzMjI4NTY1fQ.n5GE6Np9A-IefjXW3R_38bLBkx9RpXtbn6UGgVd6uRi57y7sGw022cmH8_pSnqhvxhg-ScCdNnoab1fHyubI2Q"
        let navVC = UINavigationController(rootViewController: vc)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
    }
}
