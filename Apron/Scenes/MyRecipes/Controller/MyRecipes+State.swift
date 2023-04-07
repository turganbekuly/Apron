//
//  MyRecipes+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models
import UIKit

extension MyRecipesViewController {
    
    // MARK: - State
    public enum State {
        case initial(state: MyRecipesInitialState)
        case getProfileRecipeSucceed([RecipeResponse])
        case getProfileRecipeFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            sections = [
                .init(section: .recipes, rows: [.shimmer])
            ]
            getProfileRecipes()
        case let .getProfileRecipeSucceed(recipes):
            self.recipes = recipes
            refreshControl.endRefreshing()
        case .getProfileRecipeFailed:
            refreshControl.endRefreshing()
            show(type: .error("Не удалось получить ваши рецепты! Пожалуйста, попробуйте еще раз!"))
        }
    }
    
}
