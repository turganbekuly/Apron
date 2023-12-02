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
import RemoteConfig

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
            isLoading(true)
            handleAuthorizationStatus {
                self.getProfile()
            }
        case let .fetchProfile(model):
            isLoading(false)
            userStorage.user = model
            ApronAnalytics.shared.setupUserInfo(
                id: model.id,
                name: model.username,
                email: model.email
            )
            
            let isDeleteAccountEnabled = RemoteConfigManager.shared.configManager.config(for: RemoteConfigKeys.deleteAccountEnabled)
            
            if isDeleteAccountEnabled || model.username == "akarys.turganbekuly@gmail.com" {
                sections = [
                    .init(section: .app,
                          rows: [.user, .bonus(model.bonusAmount ?? 0), .assistant, .myRecipes, .favRecipes, .deleteAccount, .contactWithDevelopers, .logout]
                         )
                ]
            } else {
                sections = [
                    .init(section: .app,
                          rows: [.user, .bonus(model.bonusAmount ?? 0), .assistant, .myRecipes, .favRecipes, .contactWithDevelopers, .logout]
                         )
                ]
            }
            
            mainView.reloadData()
        case .fetchProfileFailed:
            isLoading(false)
            show(type: .error(L10n.Alert.errorMessage))
        case .deleteAccount:
            ApronAnalytics.shared.sendAnalyticsEvent(.accountDeleted(user: userStorage.user))
            AuthStorage.shared.clear()
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
