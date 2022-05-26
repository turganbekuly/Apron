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
            AuthStorage.shared.clear()
            AuthStorage.shared.isUserAuthorized = false
        case let .loginSucceed(model):
            AuthStorage.shared.isUserAuthorized = true
            AuthStorage.shared.accessToken = model.accessToken
            let viewController = TabBarBuilder(state: .initial(.normal)).build()
            DispatchQueue.main.async {
                UIApplication.shared.windows.first?.rootViewController = viewController
            }
        case let .loginFailed(error):
            print(error)
        }
    }
    
}
