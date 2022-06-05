//
//  SplashScreen+Animation.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.06.2022.
//

import Foundation
import Storages

extension SplashScreenViewController: ISplashScreenView {
    func animationDidFinished() {
        if let token = AuthStorage.shared.refreshToken {
            updateToken(with: token)
        } else {
            AuthStorage.shared.clear()
            let vc = AuthorizationBuilder(state: .initial).build()
            DispatchQueue.main.async {
                UIApplication.shared.windows.first?.rootViewController = vc
            }
        }
    }
}
