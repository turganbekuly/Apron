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
//        let vc = RecipeCreationBuilder(state: .initial(.create(RecipeCreation()))).build()
        AuthStorage.shared.accessToken = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkaW5hc2lsLm9tYXJiZWtAZ21haWwuY29tIiwiZXhwIjoxNjUxNDAxNTcyfQ.eq2Ev9skD3W66Tup_IJnrGrA9Deyp7LZdoGHCkdQJXoRt-Zk_ZgLqr-1bJxCMBKooOAf94cAwyu4wHcKnrg02g"
        let navVC = UINavigationController(rootViewController: vc)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
    }
}
