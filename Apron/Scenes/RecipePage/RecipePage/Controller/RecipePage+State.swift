//
//  RecipePage+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import APRUIKit

extension RecipePageViewController {
    
    // MARK: - State
    public enum State {
        case initial(id: Int, RecipeCreationSourceTypeModel)
        case displayRecipe(RecipeResponse)
        case displayError(AKNetworkError)
        case rateRecipe(RatingResponse)
        case rateRecipeError(AKNetworkError)
        case saveRecipe(RecipeResponse)
        case saveRecipeFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(id, sourceType):
            self.initialState = sourceType
            getRecipe(by: id)
            showLoader()
        case let .displayRecipe(recipe):
            hideLoader()
            self.recipe = recipe
        case let .displayError(error):
            hideLoader()
            print(error)
        case let .rateRecipe(rating):
            print(rating)
        case let .rateRecipeError(error):
            print(error)
        case let .saveRecipe(newCount):
            print(newCount)
        case .saveRecipeFailed:
            show(type: .error(L10n.Common.errorMessage))
        }
    }
    
}
