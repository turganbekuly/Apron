//
//  Main+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Foundation
import Models

extension MainViewController {
    
    // MARK: - Network

    func getCommunitiesByCategory() {
        interactor.getCommunitiesByCategory(request: .init())
    }

    func getCookNowRecipes() {
        var searchFilter = SearchFilterRequestBody()
        searchFilter.dishTypes = [3]
        searchFilter.eventTypes = [1]
        searchFilter.limit = 10
        interactor.getCookNowRecipes(request: .init(body: searchFilter))

    }

    func saveRecipe(with id: Int) {
        interactor.saveRecipe(request: .init(id: id))
    }
}
