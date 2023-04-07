//
//  Main+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension MainViewController: MainDisplayLogic {

    // MARK: - MainDisplayLogic

    func displayCommunities(viewModel: MainDataFlow.GetCommunities.ViewModel) {
        state = viewModel.state
    }

    func displayCookNowRecipes(viewModel: MainDataFlow.GetCookNowRecipes.ViewModel) {
        state = viewModel.state
    }

    func displayEventRecipes(viewModel: MainDataFlow.GetEventRecipes.ViewModel) {
        state = viewModel.state
    }

    func displaySavedRecipe(viewModel: MainDataFlow.SaveRecipe.ViewModel) {
        state = viewModel.state
    }
}
