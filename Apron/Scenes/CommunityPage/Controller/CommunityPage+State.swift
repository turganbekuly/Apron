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
        case displayRecipes([RecipesResponse])
        case displayRecipesFailed(AKNetworkError)
        case saveRecipe(Int)
        case saveRecipeFailed(AKNetworkError)
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
        case let .saveRecipe(newCount):
            print(newCount)
        case let .saveRecipeFailed(error):
            print(error)
        }
    }

    private func updateList(with recipes: [RecipesResponse]) {
        if self.recipes.isEmpty {
            self.recipes = recipes.compactMap { $0.recipe }
        } else {
            self.recipes.append(contentsOf: recipes.compactMap { $0.recipe })
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
