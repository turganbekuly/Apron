//
//  Main+WhatToCookDelegates.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.12.2022.
//

import Foundation
import Models

extension MainViewController: WhatToCookCellDelegate {
    func navigateToCategoryRecipes(with type: WhatToCookCategoryTypes) {
        var searchFilter = SearchFilterRequestBody()
        switch type {
        case .zavtrak:
            searchFilter.dayTimeType = [1]
        case .obed:
            searchFilter.dayTimeType = [2]
        case .uzhin:
            searchFilter.dayTimeType = [4]
        case .salati:
            searchFilter.dishTypes = [3]
        case .pp:
            searchFilter.query = "ПП "
        case .deserti:
            searchFilter.dishTypes = [9]
        }

        let viewController = UINavigationController(
            rootViewController: RecipeSearchBuilder(state: .initial(searchFilter)).build()
        )
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        DispatchQueue.main.async { [weak self] in
            self?.tabBarController?.selectedIndex = 1
            self?.present(viewController, animated: true)
        }
    }
}
