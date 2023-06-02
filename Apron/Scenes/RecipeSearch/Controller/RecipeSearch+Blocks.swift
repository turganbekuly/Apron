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
        case .pp:
            searchFilter.query = "ПП "
        case .firstMeal:
            searchFilter.dishTypes = [1]
        case .secondMeal:
            searchFilter.dishTypes = [2]
        case .salads:
            searchFilter.dishTypes = [3]
        case .snacks:
            searchFilter.dishTypes = [4]
        case .desserts:
            searchFilter.dishTypes = [9]
        case .bakery:
            searchFilter.dishTypes = [5]
        case .saucesMarinades:
            searchFilter.dishTypes = [6]
        case .foodPrepProvision:
            searchFilter.dishTypes = [7]
        case .drinks:
            searchFilter.dishTypes = [8]
        case .sideDishes:
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
