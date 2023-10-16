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
import OneSignal
import APRUIKit

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
            ApronAnalytics.shared.sendAnalyticsEvent(
                .authorization(
                    AuthorizationModel(
                        email: model.email,
                        name: model.username ?? "",
                        sourceType: .signUp
                    )
                )
            )
            let vc = TabBarBuilder(state: .initial(.normal)).build()
            let navigationVC = UINavigationController(rootViewController: vc)
            DispatchQueue.main.async {
                UIApplication.shared.windows.first?.rootViewController = navigationVC
            }
        case let .signupFailed(error):
            ApronAnalytics.shared.sendAnalyticsEvent(.authorizationFailed("sourceType:signup, backend: \(error)"))
            AuthStorage.shared.clear()
            show(type: .error(L10n.Alert.errorMessage))
        }
    }

}
