//
//  Authorization+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit
import Models
import Storages
import APRUIKit

extension AuthorizationViewController {

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
            break
        case let .loginSucceed(model):
            hideLoader()
            AuthStorage.shared.grantType = GrantType.apple.rawValue
            AuthStorage.shared.save(model: model)
            ApronAnalytics.shared.setupUserInfo(id: 0, name: model.username, email: model.email)
            ApronAnalytics.shared.sendAnalyticsEvent(
                .authorization(
                    AuthorizationModel(
                        email: model.email,
                        name: model.username ?? "",
                        sourceType: .apple
                    )
                )
            )
            let vc = TabBarBuilder(state: .initial(.normal)).build()
            let navigationVC = UINavigationController(rootViewController: vc)
            DispatchQueue.main.async {
                UIApplication.shared.windows.first?.rootViewController = navigationVC
            }
        case .loginFailed:
            ApronAnalytics.shared.sendAnalyticsEvent(.authorizationFailed("apple"))
            AuthStorage.shared.clear()
            show(type: .error(L10n.Alert.errorMessage))
        }
    }

}
