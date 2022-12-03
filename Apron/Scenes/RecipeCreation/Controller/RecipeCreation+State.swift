//
//  RecipeCreation+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import Configurations

extension RecipeCreationViewController {
    
    // MARK: - State
    public enum State {
        case initial(RecipeCreationInitialState)
        case recipeCreationSucceed(RecipeResponse)
        case recipeCreationFailed(AKNetworkError)
        case uploadImageSucceed(String)
        case uploadImageFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(state):
            self.initialState = state
        case let .recipeCreationSucceed(recipe):
            saveButtonLoader(isLoading: false)
            recipeCreationStorage.recipeCreation = nil
            ApronAnalytics.shared.sendAnalyticsEvent(
                .recipeCreated(
                    RecipeCreatedModel(
                        recipeID: recipe.id,
                        recipeName: recipe.recipeName ?? "",
                        sourceType: analyticsSourceType ?? .community,
                        imageAdded: selectedImage != nil ? true : false,
                        ingredients: recipe.ingredients?.map { $0.product?.name ?? ""} ?? []
                    )
                )
            )
            show(type: .success("Рецепт создался успешно"), firstAction: nil, secondAction: nil)
            self.dismiss(animated: true) {
                self.delegate?.didCreate()
            }
        case .recipeCreationFailed:
            saveButtonLoader(isLoading: false)
            show(type: .error("Произошла ошибка при создании"), firstAction: nil, secondAction: nil)
        case let .uploadImageSucceed(path):
            recipeCreation?.imageURL = Configurations.downloadImageURL(imagePath: path)
            configureImageCell(isLoaded: false)
            mainView.reloadTableViewWithoutAnimation()
            replaceImageCell(type: .image)
        case .uploadImageFailed:
            configureImageCell(isLoaded: false)
            show(type: .error("Не удалось загрузить фото, попробуйте еще раз"))
        }
    }
    
}
