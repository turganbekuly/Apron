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
import RemoteConfig
import HapticTouch
import OneSignal
import APRUIKit

extension RecipeCreationViewController {

    // MARK: - State
    public enum State {
        case initial(RecipeCreationInitialState)
        case recipeEditingSucceed(RecipeResponse)
        case recipeEditingFailed(AKNetworkError)
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
            OneSignal.addTrigger("recipe_creation", withValue: "opened")
        case let .recipeCreationSucceed(recipe):
            let remoteConfigManager = RemoteConfigManager.shared
            saveButtonLoader(isLoading: false)
            recipeCreationStorage.recipeCreation = nil
            ApronAnalytics.shared.sendAnalyticsEvent(
                .recipeCreated(
                    RecipeCreatedModel(
                        recipeID: recipe.id,
                        recipeName: recipe.recipeName ?? "",
                        sourceType: analyticsSourceType ?? .community,
                        imageAdded: selectedImage != nil ? true : false,
                        ingredients: recipe.ingredients?.map { $0.product?.name ?? ""} ?? [],
                        isPaidRecipe: remoteConfigManager.remoteConfig.isPaidRecipeEnabled
                    )
                )
            )
            HapticTouch.generateSuccess()
            show(type: .success(L10n.RecipeCreation.MessageAlert.success), firstAction: nil, secondAction: nil)
            self.dismiss(animated: true) {
                self.delegate?.didCreate()
            }
        case let .recipeEditingSucceed(recipe):
            let remoteConfigManager = RemoteConfigManager.shared
            saveButtonLoader(isLoading: false)
            recipeCreationStorage.recipeCreation = nil
            ApronAnalytics.shared.sendAnalyticsEvent(
                .recipeCreated(
                    RecipeCreatedModel(
                        recipeID: recipe.id,
                        recipeName: recipe.recipeName ?? "",
                        sourceType: analyticsSourceType ?? .community,
                        imageAdded: selectedImage != nil ? true : false,
                        ingredients: recipe.ingredients?.map { $0.product?.name ?? ""} ?? [],
                        isPaidRecipe: remoteConfigManager.remoteConfig.isPaidRecipeEnabled
                    )
                )
            )
            HapticTouch.generateSuccess()
            show(type: .success(L10n.RecipeCreation.MessageAlert.success), firstAction: nil, secondAction: nil)
            self.dismiss(animated: true) {
                self.delegate?.didCreate()
            }
        case .recipeCreationFailed, .recipeEditingFailed:
            saveButtonLoader(isLoading: false)
            HapticTouch.generateError()
            show(type: .error(L10n.Alert.errorMessage), firstAction: nil, secondAction: nil)
        case let .uploadImageSucceed(path):
            recipeCreation?.imageURL = Configurations.downloadImageURL(imagePath: path)
            configureImageCell(isLoaded: false)
            mainView.reloadTableViewWithoutAnimation()
            replaceImageCell(type: .image)
        case .uploadImageFailed:
            configureImageCell(isLoaded: false)
            HapticTouch.generateError()
            show(type: .error(L10n.Alert.errorMessage))
        }
    }

}
