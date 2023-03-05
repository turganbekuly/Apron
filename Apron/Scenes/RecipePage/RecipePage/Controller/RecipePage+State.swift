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
        case saveRecipe(RecipeResponse)
        case saveRecipeFailed(AKNetworkError)
        case displayComments([RecipeCommentResponse])
        case displayCommentsFailed
    }

    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(id, sourceType):
            self.initialState = sourceType
            self.recipeId = id
            getRecipe(by: recipeId)
            showLoader()
        case let .displayRecipe(recipe):
            hideLoader()
            self.recipe = recipe
            getComments(by: recipe.id)
        case .displayError:
            hideLoader()
        case .saveRecipe:
            bottomStickyView.configure(isSaved: true)
        case .saveRecipeFailed:
            bottomStickyView.configure(isSaved: false)
            show(type: .error(L10n.Common.errorMessage))
        case let .displayComments(comment):
            self.recipeComments = comment
        case .displayCommentsFailed:
            break
        }
    }

}
