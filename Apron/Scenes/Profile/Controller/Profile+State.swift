//
//  Profile+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import Storages
import APRUIKit
import OneSignal

extension ProfileViewController {
    
    // MARK: - State
    public enum State {
        case initial
        case fetchProfile(User)
        case fetchProfileFailed(AKNetworkError)
        case deleteAccount
        case deleteAccountFailed
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            handleAuthorizationStatus {
                self.getProfile()
            }
        case let .fetchProfile(model):
            userStorage.user = model
            ApronAnalytics.shared.setupUserInfo(
                id: model.id,
                name: model.username,
                email: model.email
            )
            sections = [.init(section: .app, rows: [.user, .assistant, .deleteAccount, .logout])]
            mainView.reloadData()
        case .fetchProfileFailed:
            show(type: .error(L10n.Common.errorMessage))
        case .deleteAccount:
            AuthStorage.shared.clear()
            OneSignal.sendTag("user_account", value: "deleted")
            let vc = AuthorizationBuilder(state: .initial).build()
            vc.hidesBottomBarWhenPushed = true
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case .deleteAccountFailed:
            break
        }
    }
    
}
