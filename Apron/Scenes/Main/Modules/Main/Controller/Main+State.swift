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

extension MainViewController {
    
    // MARK: - State
    public enum State {
        case initial
        case fetchCommunitiesByCategory([CommunityCategory])
        case fetchCommunitiesByCategoryFailed(AKNetworkError)
        case fetchCookNowRecipes([RecipeResponse])
        case fetchCookNowRecipesFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
//            getCommunitiesByCategory()
            getCookNowRecipes()
        case let .fetchCommunitiesByCategory(model):
            self.dynamicCommunities = model
            endRefreshingIfNeeded()
        case .fetchCommunitiesByCategoryFailed:
            show(type: .error(L10n.Common.errorMessage))
            endRefreshingIfNeeded()
        case let .fetchCookNowRecipes(recipes):
            self.cookNowRecipes = recipes
        case let .fetchCookNowRecipesFailed(error):
            print(error)
        }
    }

    func endRefreshingIfNeeded() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
}
