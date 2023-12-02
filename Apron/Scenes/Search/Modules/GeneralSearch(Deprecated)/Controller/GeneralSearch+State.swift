//
//  GeneralSearch+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension GeneralSearchViewController {

    // MARK: - State
    public enum State {
        case initial(GeneralSearchInitialState, String? = nil)
    }

    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(initialState, query):
            self.initialState = initialState
            self.historySelectedQuery = query
        }
    }

}