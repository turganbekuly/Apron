//
//  SplashScreen+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import Storages

extension SplashScreenViewController {
    
    // MARK: - State
    enum State {
        case initial
        case updateTokenSucceed(String)
        case updateTokenFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    func updateState() {
        switch state {
        case .initial:
            break
        case let .updateTokenSucceed(accessToken):
            AuthStorage.shared.accessToken = accessToken
            AuthStorage.shared.isUserAuthorized = true
            let vc = TabBarBuilder(state: .initial(.normal)).build()
            DispatchQueue.main.async {
                UIApplication.shared.windows.first?.rootViewController = vc
            }
        case .updateTokenFailed:
            AuthStorage.shared.clear()
            let vc = AuthorizationBuilder(state: .initial).build()
            let navVC = UINavigationController(rootViewController: vc)
            navVC.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(navVC, animated: true)
            }
        }
    }
    
}
