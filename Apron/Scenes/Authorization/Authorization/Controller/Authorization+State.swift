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
            let viewController = TabBarBuilder(state: .initial(.normal)).build()
            DispatchQueue.main.async {
                UIApplication.shared.windows.first?.rootViewController = viewController
            }
        case .loginFailed:
            show(type: .error(L10n.Common.errorMessage))
        }
    }
    
}
