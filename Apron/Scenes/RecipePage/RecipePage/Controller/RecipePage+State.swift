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
import Storages

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
        case displayRecommendations([RecipeResponse])
        case displayRecommendationsFailed
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
            LastRecipeHistoryStorage().whenToCook = recipe.whenToCook
            self.recipe = recipe
            getComments(by: recipe.id)
            getRecommendations(by: recipe.id)
        case .displayError:
            hideLoader()
        case .saveRecipe:
            configureSave(isSaved: true)
        case .saveRecipeFailed:
            configureSave(isSaved: false)
            show(type: .error(L10n.Alert.errorMessage))
        case let .displayComments(comment):
            self.recipeComments = comment
        case .displayCommentsFailed:
            break
        case let .displayRecommendations(recommendations):
            self.recommendations = recommendations
        case .displayRecommendationsFailed:
            break
        }
    }

}
