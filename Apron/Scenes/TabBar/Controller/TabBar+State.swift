//
//  TabBar+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

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
            pendingDeeplinkProvider.delegate = self
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
