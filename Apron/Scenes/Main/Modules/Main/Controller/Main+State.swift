//
//  Main+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import APRUIKit
import HapticTouch
import RemoteConfig

extension MainViewController {

    // MARK: - State
    public enum State {
        case initial
        case fetchCommunitiesByCategory([CommunityCategory])
        case fetchCommunitiesByCategoryFailed(AKNetworkError)
        case fetchCookNowRecipes([RecipeResponse])
        case fetchCookNowRecipesFailed(AKNetworkError)
        case fetchEventRecipes([RecipeResponse])
        case fetchEventRecipesFailed(AKNetworkError)
        case saveRecipe(RecipeResponse)
        case saveRecipeFailed(AKNetworkError)
    }

    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            cookNowRecipesState = .loading
            configureMainPageCells()
            fetchRemoteConfigFeatures()
            getCookNowRecipes()
        case let .fetchCommunitiesByCategory(model):
            self.dynamicCommunities = model
            endRefreshingIfNeeded()
        case .fetchCommunitiesByCategoryFailed:
            show(type: .error(L10n.Alert.errorMessage))
            endRefreshingIfNeeded()
        case let .fetchCookNowRecipes(recipes):
            cookNowRecipesState = .loaded(recipes)
        case .fetchCookNowRecipesFailed:
            cookNowRecipesState = .failed
        case let .fetchEventRecipes(recipes):
            eventRecipesState = .loaded(recipes)
        case .fetchEventRecipesFailed:
            eventRecipesState = .failed
        case .saveRecipe:
            HapticTouch.generateSuccess()
        case .saveRecipeFailed:
            show(type: .error(L10n.Alert.errorMessage))
            mainView.reloadData()
        }
    }

    func fetchRemoteConfigFeatures() {
        let eventValue = remoteConfigManager.mainOccaisionNumber
        if !eventValue.isEmpty, let eventType = Int(eventValue) {
            self.eventType = eventType
            eventRecipesState = .loading
            getEventRecipes(eventType: eventType)
        }
        
        let adBanners = configManager.config(for: RemoteConfigKeys.adBannerObject)
        if !adBanners.isEmpty {
            self.adBanners = adBanners
        }
        configureMainPageCells()
    }

    func endRefreshingIfNeeded() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
}
