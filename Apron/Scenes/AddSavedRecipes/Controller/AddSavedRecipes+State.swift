//
//  AddSavedRecipes+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension AddSavedRecipesViewController {
    
    // MARK: - State
    public enum State {
        case initial(AddSavedRecipesType)
        case getSavedRecipesSucceed([RecipeResponse])
        case getSavedRecipesFailed(AKNetworkError)
        case addRecipesToCommunitySucceed
        case addRecipesToCommunityFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(initialState):
            self.initialState = initialState
            getSavedRecipes(page: currentPage)
        case let .getSavedRecipesSucceed(model):
            updateList(with: model)
        case .getSavedRecipesFailed:
            endRefreshingIfNeeded()
        case .addRecipesToCommunitySucceed:
            switch initialState {
            case .communityCreation:
                let vc = CommunityPageBuilder(state: .initial(.fromAddedRecipes(id: communityID))).build()
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .community:
                delegate?.didCreate()
                self.navigationController?.popViewController(animated: true)
            default:
                break
            }
        case let .addRecipesToCommunityFailed(error):
            print(error)
        }
    }

    private func updateList(with recipes: [RecipeResponse]) {
        if self.savedRecipes.isEmpty {
            self.savedRecipes = recipes
        } else {
            self.savedRecipes.append(contentsOf: recipes)
        }
        configureRecipes()
    }

    private func configureRecipes() {
        guard let section = sections.firstIndex(where: { $0.section == .recipes }) else { return }
        currentPage += 1
        sections[section].rows = savedRecipes.compactMap { .recipe($0) }
        endRefreshingIfNeeded()
        mainView.finishInfiniteScroll()
        mainView.reloadData()
    }

    func endRefreshingIfNeeded() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
}
