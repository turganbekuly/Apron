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
        AuthStorage.shared.accessToken = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkaW5hc2lsLm9tYXJiZWtAZ21haWwuY29tIiwiZXhwIjoxNjUyMDg3MzYxfQ.7kj00M020BqEGwEy-nHDlomnQyMBOSHoxeHwpdIrZYyiL9Mxy_gR5RRB8fy1MvKSXAgQa6fVOLfl-7kK4OxoGg"
        let navVC = UINavigationController(rootViewController: vc)
        window.rootViewController = navVC
        window.makeKeyAndVisible()
    }
}
