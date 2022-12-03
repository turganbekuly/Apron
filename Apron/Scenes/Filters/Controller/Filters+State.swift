//
//  Filters+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension FiltersViewController {
    
    // MARK: - State
    public enum State {
        case initial(SearchFilterRequestBody)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(filters):
            self.selectedFilters = filters
        }
    }
    
}
