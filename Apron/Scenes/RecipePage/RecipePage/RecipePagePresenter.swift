//
//  RecipePagePresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol RecipePagePresentationLogic: AnyObject {
    func getRecipe(response: RecipePageDataFlow.GetRecipe.Response)
    func rateRecipe(response: RecipePageDataFlow.RateRecipe.Response)
}

final class RecipePagePresenter: RecipePagePresentationLogic {
    
    // MARK: - Properties
    weak var viewController: RecipePageDisplayLogic?
    
    // MARK: - RecipePagePresentationLogic

    func getRecipe(response: RecipePageDataFlow.GetRecipe.Response) {
        DispatchQueue.main.async {
            var viewModel: RecipePageDataFlow.GetRecipe.ViewModel

            defer { self.viewController?.displayRecipe(viewModel: viewModel) }

            switch response.result {
            case let .successfull(model):
                viewModel = .init(state: .displayRecipe(model))
            case let .failed(error):
                viewModel = .init(state: .displayError(error))
            }
        }
    }

    func rateRecipe(response: RecipePageDataFlow.RateRecipe.Response) {
        DispatchQueue.main.async {
            var viewModel: RecipePageDataFlow.RateRecipe.ViewModel

            defer { self.viewController?.displayRating(viewModel: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .rateRecipe(model))
            case let .failed(error):
                viewModel = .init(state: .rateRecipeError(error))
            }
        }
    }
}
