//
//  RecipeSearchPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol RecipeSearchPresentationLogic: AnyObject {
    func getRecipes(
        response: RecipeSearchDataFlow.GetRecipes.Response
    )
    func saveRecipe(response: RecipeSearchDataFlow.SaveRecipe.Response)
}

final class RecipeSearchPresenter: RecipeSearchPresentationLogic {
    // MARK: - Properties
    weak var viewController: RecipeSearchDisplayLogic?
    
    // MARK: - RecipeSearchPresentationLogic

    func getRecipes(response: RecipeSearchDataFlow.GetRecipes.Response) {
        DispatchQueue.main.async {
            var viewModel: RecipeSearchDataFlow.GetRecipes.ViewModel

            defer { self.viewController?.displayRecipes(with: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .fetchRecipes(model))
            case let .failed(error):
                viewModel = .init(state: .fetchRecipesFailed(error))
            }
        }
    }

    func saveRecipe(response: RecipeSearchDataFlow.SaveRecipe.Response) {
        DispatchQueue.main.async {
            var viewModel: RecipeSearchDataFlow.SaveRecipe.ViewModel

            defer { self.viewController?.displaySaveRecipe(viewModel: viewModel) }

            switch response.result {
            case let .successful(recipe):
                viewModel = .init(state: .saveRecipe(recipe))
            case let .failed(error):
                viewModel = .init(state: .saveRecipeFailed(error))
            }
        }
    }
}
