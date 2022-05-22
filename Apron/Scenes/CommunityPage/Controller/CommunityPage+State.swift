//
//  CommunityPage+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension CommunityPageViewController {
    
    // MARK: - State
    public enum State {
        case initial(Int)
        case displayCommunity(CommunityResponse)
        case displayCommunityError(AKNetworkError)
        case joinedCommunity
        case joinedCommunityFailed
        case displayRecipes([RecipeResponse])
        case displayRecipesFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(id):
            getCommunities(by: id)
            getRecipesByCommunity(id: id, currentPage: currentPage)
        case let .displayCommunity(model):
            self.community = model
        case let .displayCommunityError(error):
            print(error)
        case .joinedCommunity:
            print("")
        case .joinedCommunityFailed:
            print("")
        case let .displayRecipes(model):
            updateList(with: model)
        case let .displayRecipesFailed(error):
            print(error)
        }
    }

    private func updateList(with recipes: [RecipeResponse]) {
        if self.recipes.isEmpty {
            self.recipes = recipes
        } else {
            self.recipes.append(contentsOf: recipes)
            mainView.finishInfiniteScroll()
        }

        configureRecipes()
    }

    func configureRecipes() {
        guard let section = sections.firstIndex(where: { $0.section == .topView }) else { return }
        currentPage += 1
        sections[section].rows = recipes.compactMap { .recipiesView($0) }
        mainView.reloadData()
    }
}
