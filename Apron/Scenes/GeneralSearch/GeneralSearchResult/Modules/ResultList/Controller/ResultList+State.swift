//
//  ResultList+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension ResultListViewController {
    
    // MARK: - State
    public enum State {
        case initial(GeneralSearchInitialState, String?)
        case fetchRecipesByCommunityId([RecipeResponse])
        case fetchRecipesByCommunityIdFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(initialState, query):
            self.initialState = initialState
            self.query = query
        case let .fetchRecipesByCommunityId(model):
            updateList(with: model)
        case let .fetchRecipesByCommunityIdFailed(error):
            print(error)
        }
    }

    private func updateList(with recipes: [RecipeResponse]) {
        if self.recipesList.isEmpty {
            self.recipesList = recipes
        } else {
            self.recipesList.append(contentsOf: recipes)
            mainView.finishInfiniteScroll()
        }

        configureRecipes()
    }

    func configureRecipes() {
        guard let section = sections.firstIndex(where: { $0.section == .recipes }) else { return }
        currentPage += 1
        sections[section].rows = recipesList.compactMap { .recipe($0) }
        mainView.reloadData()
    }
    
}
