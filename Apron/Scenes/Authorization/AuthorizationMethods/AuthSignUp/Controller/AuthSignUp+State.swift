//
//  AuthSignUp+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import Storages

extension AuthSignUpViewController {
    
    // MARK: - State
    public enum State {
        case initial
        case signupSucceed(Auth)
        case signupFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            break
        case let .signupSucceed(model):
            hideLoader()
            AuthStorage.shared.grantType = GrantType.native.rawValue
            AuthStorage.shared.save(model: model)
            ApronAnalytics.shared.setupUserInfo(id: 0, name: model.username, email: model.email)
            let viewController = TabBarBuilder(state: .initial(.normal)).build()
            DispatchQueue.main.async {
                UIApplication.shared.windows.first?.rootViewController = viewController
            }
        case .signupFailed:
            print("asd")
        }
    }
    
}
