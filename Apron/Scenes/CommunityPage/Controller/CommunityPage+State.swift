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
    enum State {
        case initial(CommunityPageInitialState)
        case displayCommunity(CommunityResponse)
        case displayCommunityError(AKNetworkError)
        case joinedCommunity
        case joinedCommunityFailed
        case displayRecipes([RecipeResponse])
        case displayRecipesFailed(AKNetworkError)
        case saveRecipe(RecipeResponse)
        case saveRecipeFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    func updateState() {
        switch state {
        case let .initial(initialState):
            self.initialState = initialState
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
        case let .saveRecipe(newCount):
            print(newCount)
        case let .saveRecipeFailed(error):
            print(error)
        }
    }

    private func updateList(with recipes: [RecipeResponse]) {
        if self.recipes.isEmpty {
            self.recipes = recipes
        } else {
            self.recipes.append(contentsOf: recipes)
        }

        configureRecipes()
    }

    func configureRecipes() {
        guard !recipes.isEmpty else {
            sections = [.init(section: .topView, rows: [.emptyView])]
            mainView.reloadData()
            return
        }
        guard let section = sections.firstIndex(where: { $0.section == .topView }) else { return }
        currentPage += 1
        sections[section].rows = recipes.compactMap { .recipiesView($0) }
        mainView.finishInfiniteScroll()
        mainView.reloadData()
    }
}
