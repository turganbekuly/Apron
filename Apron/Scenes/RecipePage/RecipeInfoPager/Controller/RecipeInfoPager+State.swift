//
//  RecipeInfoPager+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.01.2022.
//

import Foundation

extension RecipeInfoPagerViewController {
    enum State {
        case initial([RecipeInitialState], RecipeInitialState)
    }

    func updateState() {
        switch state {
        case let .initial(pages, currentPage):
            self.currentPage = currentPage
            self.pages = pages
        }
    }
}
