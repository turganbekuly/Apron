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
        case updateTokenSucceed(Auth)
        case updateTokenFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    func updateState() {
        switch state {
        case .initial:
            break
        case let .updateTokenSucceed(model):
            AuthStorage.shared.save(model: model)
            let vc = TabBarBuilder(state: .initial(.normal)).build()
            DispatchQueue.main.async {
                UIApplication.shared.windows.first?.rootViewController = vc
            }
        case .updateTokenFailed:
            AuthStorage.shared.clear()
            let vc = AuthorizationBuilder(state: .initial).build()
            DispatchQueue.main.async {
                UIApplication.shared.windows.first?.rootViewController = vc
            }
        }
    }
    
}
