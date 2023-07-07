//
//  RecipePage+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension RecipePageViewController: RecipePageDisplayLogic {

    // MARK: - RecipePageDisplayLogic

    func displayRecipe(viewModel: RecipePageDataFlow.GetRecipe.ViewModel) {
        state = viewModel.state
    }

    func displayRating(viewModel: RecipePageDataFlow.RateRecipe.ViewModel) {
        state = viewModel.state
    }

    func displaySaveRecipe(viewModel: RecipePageDataFlow.SaveRecipe.ViewModel) {
        state = viewModel.state
    }

    func displayComments(viewModel: RecipePageDataFlow.GetComments.ViewModel) {
        state = viewModel.state
    }
    
    func displayRecommendations(viewModel: RecipePageDataFlow.GetRecommendations.ViewModel) {
        state = viewModel.state
    }
}
