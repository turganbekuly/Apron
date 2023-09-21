//
//  SearchByIngredientsResultPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import UIKit

protocol SearchByIngredientsResultPresentationLogic: AnyObject {
    func getRecipesByIngredients(response: SearchByIngredientsResultDataFlow.GetRecipesByIngredients.Response)
}

final class SearchByIngredientsResultPresenter: SearchByIngredientsResultPresentationLogic {
    
    // MARK: - Properties
    weak var viewController: SearchByIngredientsResultDisplayLogic?
    
    // MARK: - SearchByIngredientsResultPresentationLogic
    
    func getRecipesByIngredients(response: SearchByIngredientsResultDataFlow.GetRecipesByIngredients.Response) {
        DispatchQueue.main.async {
            var viewModel: SearchByIngredientsResultDataFlow.GetRecipesByIngredients.ViewModel

            defer { self.viewController?.displayRecipes(with: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .getRecipesSucceed(model))
            case let .failed(error):
                viewModel = .init(state: .getRecipesFailed(error))
            }
        }
    }
}
