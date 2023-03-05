//
//  CreateActionFlow+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

protocol CreateActionFlowProtocol: AnyObject {
    func handleChosenAction(type: CreateActionType)
}

extension CreateActionFlowViewController {

    // MARK: - State
    public enum State {
        case initial(CreateActionInitialState, CreateActionFlowProtocol)
    }

    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(state, delegate):
            self.initialState = state
            self.delegate = delegate
        }
    }

}
