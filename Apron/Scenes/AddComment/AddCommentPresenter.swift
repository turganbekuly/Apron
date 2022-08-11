//
//  AddCommentPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol AddCommentPresentationLogic: AnyObject {
    func addComment(response: AddCommentDataFlow.AddComment.Response)
    func rateRecipe(response: AddCommentDataFlow.RateRecipe.Response)
    func uploadImage(response: AddCommentDataFlow.UploadImage.Response)
}

final class AddCommentPresenter: AddCommentPresentationLogic {
    // MARK: - Properties
    weak var viewController: AddCommentDisplayLogic?
    
    // MARK: - AddCommentPresentationLogic

    func addComment(response: AddCommentDataFlow.AddComment.Response) {
        DispatchQueue.main.async {
            var viewModel: AddCommentDataFlow.AddComment.ViewModel

            defer { self.viewController?.displayAddComment(viewModel: viewModel) }

            switch response.result {
            case let .successful(result):
                viewModel = .init(state: .commentAdded(result))
            case .failed:
                viewModel = .init(state: .commentAddingFailed)
            }
        }
    }

    func rateRecipe(response: AddCommentDataFlow.RateRecipe.Response) {
        DispatchQueue.main.async {
            var viewModel: AddCommentDataFlow.RateRecipe.ViewModel

            defer { self.viewController?.displayRateRecipe(viewModel: viewModel) }

            switch response.result {
            case .successful:
                viewModel = .init(state: .rateRecipe)
            case .failed:
                viewModel = .init(state: .rateRecipeError)
            }
        }
    }

    func uploadImage(response: AddCommentDataFlow.UploadImage.Response) {
        DispatchQueue.main.async {
            var viewModel: AddCommentDataFlow.UploadImage.ViewModel

            defer { self.viewController?.displayUploadImage(viewModel: viewModel) }

            switch response.result {
            case let .successful(imagePath):
                viewModel = .init(state: .uploadImageSucceed(imagePath))
            case let .failed(error):
                viewModel = .init(state: .uploadImageFailed(error))
            }
        }
    }
}
