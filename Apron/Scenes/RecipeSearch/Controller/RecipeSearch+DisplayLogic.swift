//
//  RecipeSearch+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension RecipeSearchViewController: RecipeSearchDisplayLogic {
    
    // MARK: - RecipeSearchDisplayLogic

    func displayRecipes(with viewModel: RecipeSearchDataFlow.GetRecipes.ViewModel) {
        state = viewModel.state
    }

    func displaySaveRecipe(viewModel: RecipeSearchDataFlow.SaveRecipe.ViewModel) {
        state = viewModel.state
    }
}
