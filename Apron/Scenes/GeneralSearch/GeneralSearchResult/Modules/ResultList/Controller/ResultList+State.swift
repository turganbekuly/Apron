//
//  ResultList+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension ResultListViewController {
    
    // MARK: - State
    public enum State {
        case initial(GeneralSearchInitialState, String?)
        case fetchRecipesByCommunityId([RecipeResponse])
        case fetchRecipesByCommunityIdFailed(AKNetworkError)
        case fetchEverything(SearchEverythingResponse)
        case fetchEverythingFailed(AKNetworkError)
        case fetchSavedRecipes([RecipeResponse])
        case fetchSavedRecipesFailed(AKNetworkError)
        case fetchRecipes([RecipesResponse])
        case fetchRecipesFailed(AKNetworkError)
        case fetchCommunities([CommunityResponse])
        case fetchCommunitiesFailed(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(initialState, query):
            self.initialState = initialState
            self.query = query
        case let .fetchRecipesByCommunityId(model):
//            updateRecipiesList(with: model)
            print(model)
        case let .fetchRecipesByCommunityIdFailed(error):
            print(error)
        case let .fetchEverything(model):
            self.recipesList = model.recipes?.compactMap { $0.recipe } ?? []
            sections = [
                .init(section: .everything, rows: recipesList.compactMap { .recipe($0) }),
                .init(section: .everything, rows: model.communities?.compactMap { .community($0) } ?? [])
            ]
            mainView.reloadData()
        case let .fetchEverythingFailed(error):
            print(error)
        case let .fetchSavedRecipes(model):
//            updateRecipiesList(with: model)
            print(model)
        case let .fetchSavedRecipesFailed(error):
            print(error)
        case let .fetchRecipes(model):
            updateRecipiesList(with: model)
        case let .fetchRecipesFailed(error):
            print(error)
        case let .fetchCommunities(model):
            updateCommunitiesList(with: model)
        case let .fetchCommunitiesFailed(error):
            print(error)
        }
    }

    // MARK: - Recipes Infinite Scroll

    private func updateRecipiesList(with recipes: [RecipesResponse]) {
        if self.recipesList.isEmpty {
            self.recipesList = recipes.compactMap { $0.recipe }
        } else {
            self.recipesList.append(contentsOf: recipes.compactMap { $0.recipe })
        }

        configureRecipes()
    }

    private func configureRecipes() {
        guard let section = sections.firstIndex(where: { $0.section == .recipes }) else { return }
        currentPage += 1
        sections[section].rows = recipesList.compactMap { .recipe($0) }
        mainView.finishInfiniteScroll()
        mainView.reloadData()
    }

    // MARK: - Communities Infinite Scroll

    private func updateCommunitiesList(with communities: [CommunityResponse]) {
        if self.communitiesList.isEmpty {
            self.communitiesList = communities
        } else {
            self.communitiesList.append(contentsOf: communities)
        }

        configureCommunities()
    }

    private func configureCommunities() {
        guard let section = sections.firstIndex(where: { $0.section == .communities }) else { return }
        currentPage += 1
        sections[section].rows = communitiesList.compactMap { .community($0) }
        mainView.finishInfiniteScroll()
        mainView.reloadData()
    }
    
}
