//
//  RecipeCreationPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol RecipeCreationPresentationLogic: AnyObject {
    func createRecipe(response: RecipeCreationDataFlow.CreateRecipe.Response)
    func editRecipe(response: RecipeCreationDataFlow.CreateRecipe.Response)
    func uploadImage(response: RecipeCreationDataFlow.UploadImage.Response)
}

final class RecipeCreationPresenter: RecipeCreationPresentationLogic {

    // MARK: - Properties
    weak var viewController: RecipeCreationDisplayLogic?

    // MARK: - RecipeCreationPresentationLogic

    func createRecipe(response: RecipeCreationDataFlow.CreateRecipe.Response) {
        DispatchQueue.main.async {
            var viewModel: RecipeCreationDataFlow.CreateRecipe.ViewModel

            defer { self.viewController?.displayRecipe(viewModel: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .recipeCreationSucceed(model))
            case let .failed(error):
                viewModel = .init(state: .recipeCreationFailed(error))
            }
        }
    }

    func editRecipe(response: RecipeCreationDataFlow.CreateRecipe.Response) {
        DispatchQueue.main.async {
            var viewModel: RecipeCreationDataFlow.CreateRecipe.ViewModel

            defer { self.viewController?.displayRecipe(viewModel: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .recipeCreationSucceed(model))
            case let .failed(error):
                viewModel = .init(state: .recipeCreationFailed(error))
            }
        }
    }

    func uploadImage(response: RecipeCreationDataFlow.UploadImage.Response) {
        DispatchQueue.main.async {
            var viewModel: RecipeCreationDataFlow.UploadImage.ViewModel

            defer { self.viewController?.displayUploadedImage(with: viewModel) }

            switch response.result {
            case let .successful(imagePath):
                viewModel = .init(state: .uploadImageSucceed(imagePath))
            case let .failed(error):
                viewModel = .init(state: .uploadImageFailed(error))
            }
        }
    }
}
