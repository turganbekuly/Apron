//
//  GeneralSearchResultPager+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension GeneralSearchResultPagerViewController {
    
    // MARK: - State
    public enum State {
        case initial([GeneralSearchInitialState], GeneralSearchInitialState)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(pages, currentPage):
            self.currentPage = currentPage
            self.pages = pages
        }
    }
    
}
