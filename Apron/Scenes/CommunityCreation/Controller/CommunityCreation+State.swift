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
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(initialState):
            self.initialState = initialState
        }
    }
    
}
