//
//  RecipeSearch+HeaderViewDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 06.12.2022.
//

import Foundation
import Models

extension RecipeSearchViewController: RecipeSearchFilterHeaderViewProtocol {
    func headerViewTapped() {
        let viewController = FiltersBuilder(state: .initial(self.filters, self)).build()
        let navigationViewController = FiltersNavigationController(rootViewController: viewController)
        navigationViewController.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            self.navigationController?.present(navigationViewController, animated: true)
        }
    }
}

extension RecipeSearchViewController: ApplyFiltersProtocol {
    func filtersApplied(filters: SearchFilterRequestBody) {
        recipesList.removeAll()
        currentPage = 1
        sections = [
            .init(section: .filter, rows: [.shimmer])
        ]
        self.filtersCount = filters.dayTimeType.count + filters.cuisines.count + filters.eventTypes.count + filters.time.count + filters.dishTypes.count + filters.lifestyleTypes.count
        mainView.reloadData()
        self.filters = filters
        self.query = query ?? ""
        self.getRecipes(filters: self.filters)
    }
}
