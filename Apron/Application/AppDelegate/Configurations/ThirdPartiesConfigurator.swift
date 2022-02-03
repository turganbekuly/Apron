//
//  ThirdPartiesConfigurator.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28.12.2021.
//

import Foundation
//import Firebase
import Protocols

final class ThirdPartiesConfigurator: ApplicationConfiguratorProtocol {
    // MARK: - Methods

    func configure(_ application: UIApplication?, launchOptions: [UIApplication.LaunchOptionsKey : Any]?) {
        configureFirebase()
    }

    private func configureFirebase() {
//        FirebaseApp.configure()
    }
}
