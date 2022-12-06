//
//  Filters+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

protocol ApplyFiltersProtocol: AnyObject {
    func filtersApplied(filters: SearchFilterRequestBody)
}

extension FiltersViewController {
    
    // MARK: - State
    public enum State {
        case initial(SearchFilterRequestBody, ApplyFiltersProtocol)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(filters, delegate):
            self.selectedFilters = filters
            self.delegate = delegate
        }
    }
    
}
