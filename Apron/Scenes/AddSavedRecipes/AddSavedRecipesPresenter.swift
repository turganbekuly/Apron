//
//  AddSavedRecipesPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol AddSavedRecipesPresentationLogic: AnyObject {
    func getSavedRecipes(
        response: AddSavedRecipesDataFlow.GetSavedRecipe.Response
    )

    func addRecipesToCommunity(
        response: AddSavedRecipesDataFlow.AddToCommunity.Response
    )
}

final class AddSavedRecipesPresenter: AddSavedRecipesPresentationLogic {

    // MARK: - Properties
    weak var viewController: AddSavedRecipesDisplayLogic?

    // MARK: - AddSavedRecipesPresentationLogic

    func getSavedRecipes(response: AddSavedRecipesDataFlow.GetSavedRecipe.Response) {
        DispatchQueue.main.async {
            var viewModel: AddSavedRecipesDataFlow.GetSavedRecipe.ViewModel

            defer { self.viewController?.displaySavedRecipes(with: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .getSavedRecipesSucceed(model))
            case let .failed(error):
                viewModel = .init(state: .getSavedRecipesFailed(error))
            }
        }
    }

    func addRecipesToCommunity(response: AddSavedRecipesDataFlow.AddToCommunity.Response) {
        DispatchQueue.main.async {
            var viewModel: AddSavedRecipesDataFlow.AddToCommunity.ViewModel

            defer { self.viewController?.displayCommunityRecipes(with: viewModel) }

            switch response.result {
            case .successful:
                viewModel = .init(state: .addRecipesToCommunitySucceed)
            case let .failed(error):
                viewModel = .init(state: .addRecipesToCommunityFailed(error))
            }
        }
    }
}
