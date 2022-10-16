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
        case initial
        case fetchRecipes([RecipeResponse])
        case fetchRecipesFailed(AKNetworkError)
        case saveRecipe(RecipeResponse)
        case saveRecipeFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            break
        case let .fetchRecipes(model):
            updateRecipiesList(with: model.filter { $0.isHidden == false })
        case let .fetchRecipesFailed(error):
            print(error)
        case .saveRecipe:
            HapticTouch.generateSuccess()
        case .saveRecipeFailed:
            show(type: .error(L10n.Common.errorMessage))
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
        guard let section = sections.firstIndex(where: { $0.section == .results }) else { return }
        currentPage += 1
        sections[section].rows = recipesList.compactMap { .result($0) }
        mainView.finishInfiniteScroll()
        mainView.reloadData()
    }

    private func cofigureEmptyRecipes() {
        guard let section = sections.firstIndex(where: { $0.section == .shimmer }) else { return }
        currentPage += 1
        sections[section].rows = recipesList.compactMap { .result($0) }
        mainView.finishInfiniteScroll()
        mainView.reloadData()
    }
}
