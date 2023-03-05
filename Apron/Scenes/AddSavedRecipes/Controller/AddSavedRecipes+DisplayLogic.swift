//
//  AddSavedRecipes+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension AddSavedRecipesViewController: AddSavedRecipesDisplayLogic {

    // MARK: - AddSavedRecipesDisplayLogic

    func displaySavedRecipes(with viewModel: AddSavedRecipesDataFlow.GetSavedRecipe.ViewModel) {
        state = viewModel.state
    }

    func displayCommunityRecipes(with viewModel: AddSavedRecipesDataFlow.AddToCommunity.ViewModel) {
        state = viewModel.state
    }
}
