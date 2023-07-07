//
//  Search+Blocks.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.12.2022.
//

import Foundation
import Models

extension SearchViewController {
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

        let viewController = UINavigationController(
            rootViewController: RecipeSearchBuilder(state: .initial(.generalSearch(searchFilter))).build()
        )
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        DispatchQueue.main.async { [weak self] in
            self?.present(viewController, animated: true)
        }
    }
}
