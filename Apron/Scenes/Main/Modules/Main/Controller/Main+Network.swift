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
        let today = Date()
        let hours = Calendar.current.component(.hour, from: today)
        var searchFilter = SearchFilterRequestBody()
        searchFilter.currentTime = hours
        interactor.getCookNowRecipes(request: .init(body: searchFilter))
    }
}
