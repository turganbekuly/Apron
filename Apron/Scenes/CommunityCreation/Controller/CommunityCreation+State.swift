//
//  CommunityCreation+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension CommunityCreationViewController {
    
    // MARK: - State
    public enum State {
        case initial(CommunityCreationInitialState)
        case communityCreationSucceed(CommunityResponse)
        case communityCreationFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(initialState):
            self.initialState = initialState
        case let .communityCreationSucceed(community):
            let vc = AddSavedRecipesBuilder(state: .initial(.community(community.id))).build()
            dismiss(animated: true) {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case .communityCreationFailed:
            show(type: .error("Произошла ошибка при создании"), firstAction: nil, secondAction: nil)
        }
    }
    
}
