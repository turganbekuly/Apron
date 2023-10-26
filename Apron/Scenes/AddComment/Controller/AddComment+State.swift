//
//  AddComment+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import Configurations
import APRUIKit

extension AddCommentViewController {

    // MARK: - State
    public enum State {
        case initial(Int?, AddCommentRequestBody, RecipePageCommentAdded?)
        case rateRecipe
        case rateRecipeError
        case commentAdded(AddCommentResultType)
        case commentAddingFailed
        case uploadImageSucceed(String)
        case uploadImageFailed(AKNetworkError)
    }

    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(recipeId, addCommentRequestBody, delegate):
            self.recipeId = recipeId
            self.addCommentRequestBody = addCommentRequestBody
            self.delegate = delegate
        case .rateRecipe, .rateRecipeError:
            delegate?.commentDidAdd()
            navigationController?.popViewController(animated: true)
        case let .commentAdded(response):
            switch response {
            case .success:
                if let selectedRate = selectedRate {
                    rateRecipe(positive: selectedRate == .love ? true : false)
                    return
                }

                delegate?.commentDidAdd()
                ApronAnalytics.shared.sendAnalyticsEvent(
                    .ratingPageResult(
                        rate: selectedRate?.rawValue ?? 3,
                        description: addCommentRequestBody?.comment ?? "",
                        hasPhoto: addCommentRequestBody?.image != nil ? true : false
                    )
                )
                navigationController?.popViewController(animated: true)
            case .failed:
                show(type: .error(L10n.AddComment.SendMessageError.title))
            }
        case .commentAddingFailed:
            show(type: .error(L10n.AddComment.SendMessageError.title))
        case let .uploadImageSucceed(path):
            addCommentRequestBody?.image = Configurations.downloadImageURL(imagePath: path)
            configureImageCell(isLoaded: false)
            mainView.reloadTableViewWithoutAnimation()
            replaceImageCell(type: .image)
        case .uploadImageFailed(_):
            configureImageCell(isLoaded: false)
            show(type: .error(L10n.Photo.UploadPhoto.Error.title))
        }
    }

}
