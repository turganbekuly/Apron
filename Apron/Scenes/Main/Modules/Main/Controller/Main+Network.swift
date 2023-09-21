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

    func getCookNowRecipes() {
        var searchFilter = SearchFilterRequestBody()
        searchFilter.dayTimeType = [defineRecipeDayTime().rawValue]
        interactor.getCookNowRecipes(request: .init(body: searchFilter))
    }

    func getEventRecipes(eventType: Int) {
        var searchFilter = SearchFilterRequestBody()
        searchFilter.eventTypes = [eventType]
        interactor.getEventRecipes(request: .init(body: searchFilter))
    }

    func saveRecipe(with id: Int) {
        interactor.saveRecipe(request: .init(id: id))
    }
    
    func getCommunitiesBy(ids: [Int]) {
        interactor.getCommunitiesById(communityIds: ids)
    }
    
    func getProductsByIds(ids: [Int]) {
        interactor.getProductsByIds(request: .init(ids: ids))
    }
}
