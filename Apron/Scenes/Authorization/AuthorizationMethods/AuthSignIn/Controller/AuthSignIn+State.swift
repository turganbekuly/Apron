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
import OneSignal

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
            ApronAnalytics.shared.setupUserInfo(id: 0, name: model.username, email: model.email)
            ApronAnalytics.shared.sendAnalyticsEvent(
                .authorization(
                    AuthorizationModel(
                        email: model.email,
                        name: model.username ?? "",
                        sourceType: .signIn
                    )
                )
            )
            OneSignal.sendTag("authorization_page", value: "signed_in")
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
