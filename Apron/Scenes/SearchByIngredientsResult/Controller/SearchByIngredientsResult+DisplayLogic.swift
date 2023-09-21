//
//  SearchByIngredientsResult+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import UIKit

extension SearchByIngredientsResultViewController: SearchByIngredientsResultDisplayLogic {
    
    // MARK: - SearchByIngredientsResultDisplayLogic
    
    func displayRecipes(with viewModel: SearchByIngredientsResultDataFlow.GetRecipesByIngredients.ViewModel) {
        state = viewModel.state
    }
}
