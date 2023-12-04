//
//  TabBar+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import OneSignal

extension TabBarViewController {

    // MARK: - State
     enum State {
        case initial(TabBarInitialState)
    }

    // MARK: - Methods
     func updateState() {
        switch state {
        case let .initial(state):
            configureTabBar()
            configureInitialState(state)
            performDeeplink()
            pendingDeeplinkProvider.delegate = self
            OneSignal.addTrigger("current_app_version", withValue: Bundle.main.appVersion)
        }
    }

    private func configureInitialState(_ state: TabBarInitialState?) {
        switch state {
        case .onboarding:
            selectedIndex = 0
        default:
            break
        }
    }

}
