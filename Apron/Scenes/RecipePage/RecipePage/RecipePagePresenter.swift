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
    func saveRecipe(response: RecipePageDataFlow.SaveRecipe.Response)
    func getComments(response: RecipePageDataFlow.GetComments.Response)
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

    func saveRecipe(response: RecipePageDataFlow.SaveRecipe.Response) {
        DispatchQueue.main.async {
            var viewModel: RecipePageDataFlow.SaveRecipe.ViewModel

            defer { self.viewController?.displaySaveRecipe(viewModel: viewModel) }

            switch response.result {
            case let .successful(recipe):
                viewModel = .init(state: .saveRecipe(recipe))
            case let .failed(error):
                viewModel = .init(state: .saveRecipeFailed(error))
            }
        }
    }

    func getComments(response: RecipePageDataFlow.GetComments.Response) {
        DispatchQueue.main.async {
            var viewModel: RecipePageDataFlow.GetComments.ViewModel

            defer { self.viewController?.displayComments(viewModel: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .displayComments(model))
            case .failed:
                viewModel = .init(state: .displayCommentsFailed)
            }
        }
    }
}
