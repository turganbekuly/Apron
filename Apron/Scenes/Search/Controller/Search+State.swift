//
//  Search+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension SearchViewController {
    
    // MARK: - State
    public enum State {
        case initial(SearchTypes)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(types):
            self.searchTypes = types
            getSearchHistory()
            sections = [.init(section: .search, rows: [.searchHistory])]
        }
    }
    
}
