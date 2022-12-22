//
//  RecipeSearch+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import APRUIKit
import HapticTouch

extension RecipeSearchViewController {
    
    // MARK: - State
    public enum State {
        case initial(SearchFilterRequestBody)
        case fetchRecipes([RecipeResponse])
        case fetchRecipesFailed(AKNetworkError)
        case saveRecipe(RecipeResponse)
        case saveRecipeFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(incomingFilters):
            filters = incomingFilters
            guard filters.ifAnyArrayContainsValue() else { return }
            recipesList.removeAll()
            currentPage = 1
            sections = [
                .init(section: .filter, rows: [.shimmer])
            ]
            mainView.reloadData()

            filters.page = currentPage
            getRecipes(filters: filters)
        case let .fetchRecipes(model):
            updateRecipiesList(with: model.filter { $0.isHidden == false })
        case let .fetchRecipesFailed(error):
            print(error)
        case .saveRecipe:
            HapticTouch.generateSuccess()
        case .saveRecipeFailed:
            show(type: .error(L10n.Common.errorMessage))
            mainView.reloadData()
        }
    }

    private func updateRecipiesList(with recipes: [RecipeResponse]) {
        mainView.finishInfiniteScroll()
        if self.recipesList.isEmpty {
            self.recipesList = recipes.compactMap { $0 }
            cofigureEmptyRecipes()
        } else {
            self.recipesList.append(contentsOf: recipes.compactMap { $0 })
            configureRecipes()
        }
    }

    private func configureRecipes() {
        guard let section = sections.firstIndex(where: { $0.section == .filter }) else { return }
        currentPage += 1
        sections[section].rows = recipesList.compactMap { .result($0) }
        mainView.finishInfiniteScroll()
        mainView.reloadData()
    }

    private func cofigureEmptyRecipes() {
        guard let section = sections.firstIndex(where: { $0.section == .filter }) else { return }
        currentPage += 1
        sections[section].rows = recipesList.compactMap { .result($0) }
        mainView.finishInfiniteScroll()
        mainView.reloadData()
    }
}
