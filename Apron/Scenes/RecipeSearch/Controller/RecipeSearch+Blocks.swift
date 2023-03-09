//
//  RecipeSearch+Blocks.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09.03.2023.
//

import Foundation
import Models

extension RecipeSearchViewController {
    func select(block type: SearchSuggestionCategoriesTypes) {
        var searchFilter = SearchFilterRequestBody()
        switch type {
        case .pervieBluda:
            searchFilter.dishTypes = [1]
        case .vtorieBluda:
            searchFilter.dishTypes = [2]
        case .salati:
            searchFilter.dishTypes = [3]
        case .zakuski:
            searchFilter.dishTypes = [4]
        case .deserti:
            searchFilter.dishTypes = [9]
        case .vipechki:
            searchFilter.dishTypes = [5]
        case .souciMarinadi:
            searchFilter.dishTypes = [6]
        case .zagotovki:
            searchFilter.dishTypes = [7]
        case .napitki:
            searchFilter.dishTypes = [8]
        case .garniri:
            searchFilter.dishTypes = [10]
        }

        searchBar.resignFirstResponder()
        sections = [
            .init(section: .filter, rows: [.shimmer])
        ]
        mainView.reloadData()

        getRecipes(filters: filters)

    }
}
