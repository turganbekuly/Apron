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
        case fetchCookNowRecipes([RecipeResponse])
        case fetchCookNowRecipesFailed(AKNetworkError)
        case fetchEventRecipes([RecipeResponse])
        case fetchEventRecipesFailed(AKNetworkError)
        case saveRecipe(RecipeResponse)
        case saveRecipeFailed(AKNetworkError)
        case fetchCommunities([CommunityResponse])
        case fetchCommunitiesFailed
        case fetchedProductsByIds([Product])
        case fetchedProductsByIdsFailed(AKNetworkError)
    }

    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            cookNowRecipesState = .loading
            configureMainPageCells()
            fetchRemoteConfigFeatures()
            getCookNowRecipes(filters: filters)
            let communitiesList = RemoteConfigManager.shared.configManager.config(for: RemoteConfigKeys.communitiesList)
            if !communitiesList.isEmpty {
                getCommunitiesBy(ids: communitiesList)
            }
            getProductsByIds(ids: [13, 108, 219, 237, 272])
        case let .fetchCookNowRecipes(recipes):
            cookNowRecipesState = .loaded(recipes)
            updateRecipiesList(with: recipes)
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
        case let .fetchCommunities(communities):
            self.communities = communities
        case .fetchCommunitiesFailed:
            show(type: .error(L10n.Alert.errorMessage))
        case let .fetchedProductsByIds(products):
            self.products = products
        case .fetchedProductsByIdsFailed:
            show(type: .error(L10n.Alert.errorMessage))
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
    
    private func updateRecipiesList(with recipes: [RecipeResponse]) {
        mainView.finishInfiniteScroll()
        if self.cookNowRecipes.isEmpty {
            self.cookNowRecipes = recipes.compactMap { $0 }
            cofigureEmptyRecipes()
        } else {
            self.cookNowRecipes.append(contentsOf: recipes.compactMap { $0 })
            configureRecipes()
        }
    }

    private func configureRecipes() {
        guard let section = sections.firstIndex(where: { $0.section == .cookNow }) else { return }
        currentPage += 1
        sections[section].rows = cookNowRecipes.compactMap { .cookNow($0) }
        mainView.finishInfiniteScroll()
        mainView.reloadData()
    }

    private func cofigureEmptyRecipes() {
        guard let section = sections.firstIndex(where: { $0.section == .cookNow }) else { return }
        currentPage += 1
        sections[section].rows = cookNowRecipes.compactMap { .cookNow($0) }
        mainView.finishInfiniteScroll()
        mainView.reloadData()
    }
}
