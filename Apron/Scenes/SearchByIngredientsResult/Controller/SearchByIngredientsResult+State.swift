//
//  SearchByIngredientsResult+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models
import UIKit
import APRUIKit

extension SearchByIngredientsResultViewController {
    
    // MARK: - State
    public enum State {
        case initial(productIds: [String])
        case getRecipesSucceed([RecipeResponse])
        case getRecipesFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(productIds):
            getRecipes(with: SearchByIngredientsResult(productIds: productIds, size: 50))
        case let .getRecipesSucceed(recipes):
            self.recipes = recipes
        case .getRecipesFailed:
            show(type: .error(L10n.Alert.errorMessage))
        }
    }
    
}
