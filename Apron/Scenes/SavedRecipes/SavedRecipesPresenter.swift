//
//  SavedRecipesPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol SavedRecipesPresentationLogic: AnyObject {
    func getSavedRecipes(
        response: SavedRecipesDataFlow.GetSavedRecipe.Response
    )
}

final class SavedRecipesPresenter: SavedRecipesPresentationLogic {

    // MARK: - Properties
    weak var viewController: SavedRecipesDisplayLogic?

    // MARK: - SavedRecipesPresentationLogic

    func getSavedRecipes(response: SavedRecipesDataFlow.GetSavedRecipe.Response) {
        DispatchQueue.main.async {
            var viewModel: SavedRecipesDataFlow.GetSavedRecipe.ViewModel

            defer { self.viewController?.displaySavedRecipes(with: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .getSavedRecipesSucceed(model))
            case let .failed(error):
                viewModel = .init(state: .getSavedRecipesFailed(error))
            }
        }
    }
}
