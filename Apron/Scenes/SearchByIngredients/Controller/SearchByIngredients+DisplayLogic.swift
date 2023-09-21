//
//  SearchByIngredients+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import UIKit

extension SearchByIngredientsViewController: SearchByIngredientsDisplayLogic {
    
    // MARK: - SearchByIngredientsDisplayLogic
    
    func displayProductsByIds(viewModel: SearchByIngredientsDataFlow.GetProductsByIDs.ViewModel) {
        self.state = viewModel.state
    }
    
    func displayProductsByName(viewModel: SearchByIngredientsDataFlow.GetProductsByName.ViewModel) {
        self.state = viewModel.state
    }
}
