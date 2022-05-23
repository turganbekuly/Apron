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
        AuthStorage.shared.accessToken = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkaW5hc2lsLm9tYXJiZWtAZ21haWwuY29tIiwiZXhwIjoxNjUzMzI3NjcyfQ.uJLBxQiM98WVyn8Q8QY-K4eLvuR_w9jJDnmOevfpKwzzdtmAcjzor9Ti1-a0lUBp_wXg1aLlKxKXO7vKOjwLfQ"
        let navVC = UINavigationController(rootViewController: vc)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
    }
}
