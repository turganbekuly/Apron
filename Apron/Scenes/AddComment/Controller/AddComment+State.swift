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

extension AddCommentViewController {
    
    // MARK: - State
    public enum State {
        case initial(Int?, AddCommentRequestBody)
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
        case let .initial(recipeId, addCommentRequestBody):
            self.recipeId = recipeId
            self.addCommentRequestBody = addCommentRequestBody
        case .rateRecipe, .rateRecipeError:
            break
        case let .commentAdded(response):
            switch response {
            case .success:
                break
            case .failed:
                show(type: .error("Произошла ошибка при отправке, пожалуйста, попробуйте позднее"))
            }
        case .commentAddingFailed:
            show(type: .error("Произошла ошибка при отправке, пожалуйста, попробуйте позднее"))
        case let .uploadImageSucceed(path):
            addCommentRequestBody?.image = Configurations.downloadImageURL(imagePath: path)
            configureImageCell(isLoaded: false)
            mainView.reloadTableViewWithoutAnimation()
            replaceImageCell(type: .image)
        case .uploadImageFailed(_):
            configureImageCell(isLoaded: false)
            show(type: .error("Не удалось загрузить фото, попробуйте еще раз"))
        }
    }
    
}
