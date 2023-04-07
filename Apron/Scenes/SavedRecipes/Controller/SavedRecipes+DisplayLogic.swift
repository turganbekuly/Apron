//
//  SavedRecipes+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension SavedRecipesViewController: SavedRecipesDisplayLogic {

    // MARK: - SavedRecipesDisplayLogic

    func displaySavedRecipes(with viewModel: SavedRecipesDataFlow.GetSavedRecipe.ViewModel) {
        state = viewModel.state
    }
}
