//
//  MyRecipes+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import UIKit

extension MyRecipesViewController: MyRecipesDisplayLogic {
    
    // MARK: - MyRecipesDisplayLogic

    func displayProfileRecipes(with viewModel: MyRecipesDataFlow.GetMyRecipesData.ViewModel) {
        state = viewModel.state
    }
}
