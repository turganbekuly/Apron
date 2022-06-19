//
//  SavedRecipes+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension SavedRecipesViewController {
    
    // MARK: - State
    public enum State {
        case initial
        case getSavedRecipesSucceed([RecipeResponse])
        case getSavedRecipesFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            getSavedRecipes(page: currentPage)
        case let .getSavedRecipesSucceed(model):
            updateList(with: model)
        case .getSavedRecipesFailed:
            endRefreshingIfNeeded()
        }
    }

    private func updateList(with recipes: [RecipeResponse]) {
        if self.savedRecipes.isEmpty {
            self.savedRecipes = recipes
        } else {
            self.savedRecipes.append(contentsOf: recipes)
        }
        configureRecipes()
    }

    private func configureRecipes() {
        guard let section = sections.firstIndex(where: { $0.section == .recipes }) else { return }
        currentPage += 1
        sections[section].rows = savedRecipes.compactMap { .recipe($0) }
        endRefreshingIfNeeded()
        mainView.finishInfiniteScroll()
        mainView.reloadData()
    }

    func endRefreshingIfNeeded() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
}
