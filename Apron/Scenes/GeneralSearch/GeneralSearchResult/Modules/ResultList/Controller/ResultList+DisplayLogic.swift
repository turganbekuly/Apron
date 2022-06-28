//
//  ResultList+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension ResultListViewController: ResultListDisplayLogic {

    // MARK: - ResultListDisplayLogic

    func displayRecipesByCommunityID(with viewModel: ResultListDataFlow.GetRecipesByCommunityID.ViewModel) {
        state = viewModel.state
    }

    func displayEverything(with viewModel: ResultListDataFlow.GetEverything.ViewModel) {
        state = viewModel.state
    }

    func displaySavedRecipes(with viewModel: ResultListDataFlow.GetSavedRecipes.ViewModel) {
        state = viewModel.state
    }

    func displayRecipes(with viewModel: ResultListDataFlow.GetRecipes.ViewModel) {
        state = viewModel.state
    }

    func displayCommunities(with viewModel: ResultListDataFlow.GetCommunities.ViewModel) {
        state = viewModel.state
    }

    func displaySaveRecipe(viewModel: ResultListDataFlow.SaveRecipe.ViewModel) {
        state = viewModel.state
    }

    func displayJoinCommunity(viewModel: ResultListDataFlow.JoinCommunity.ViewModel) {
        state = viewModel.state
    }
}
