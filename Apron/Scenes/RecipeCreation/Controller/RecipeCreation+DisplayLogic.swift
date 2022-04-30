//
//  RecipeCreation+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension RecipeCreationViewController: RecipeCreationDisplayLogic {
    
    // MARK: - RecipeCreationDisplayLogic

    func displayRecipe(viewModel: RecipeCreationDataFlow.CreateRecipe.ViewModel) {
        state = viewModel.state
    }
}
