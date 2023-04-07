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
    enum State {
        case initial([GeneralSearchInitialState], GeneralSearchInitialState, ResultListViewControllerDelegate?)
    }

    // MARK: - Methods
    func updateState() {
        switch state {
        case let .initial(pages, currentPage, delegate):
            self.currentPage = currentPage
            self.selectionDelegate = delegate
            self.pages = pages
        }
    }

}
