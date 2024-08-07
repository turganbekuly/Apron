//
//  GeneralSearchResult+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension GeneralSearchResultViewController {

    // MARK: - State
    public enum State {
        case initial(GeneralSearchInitialState, ResultListViewControllerDelegate?)
    }

    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(initialState, delegate):
            self.delegate = delegate
            self.initialState = initialState
        }
    }

}
