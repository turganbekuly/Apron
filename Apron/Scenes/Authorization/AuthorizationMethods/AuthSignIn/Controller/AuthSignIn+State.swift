//
//  AuthSignIn+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import Storages

extension AuthSignInViewController {
    
    // MARK: - State
    public enum State {
        case initial
        case loginSucceed(Auth)
        case loginFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            AuthStorage.shared.clear()
        case let .loginSucceed(model):
            hideLoader()
            AuthStorage.shared.grantType = GrantType.native.rawValue
            AuthStorage.shared.save(model: model)
            let viewController = TabBarBuilder(state: .initial(.normal)).build()
            DispatchQueue.main.async {
                UIApplication.shared.windows.first?.rootViewController = viewController
            }
        case .loginFailed:
            hideLoader()
            show(type: .error("Не удалось войти. Пожалуйста, попробуйте еще раз!"))
        }
    }
    
}
