//
//  CreateActionFlow+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension CreateActionFlowViewController {
    
    // MARK: - State
    public enum State {
        case initial(CreateActionInitialState)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(state):
            self.initialState = state
        }
    }
    
}
