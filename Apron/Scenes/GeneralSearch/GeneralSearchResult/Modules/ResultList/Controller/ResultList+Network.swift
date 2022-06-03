//
//  ResultList+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

extension ResultListViewController {
    
    // MARK: - Network

    func getRecipesByCommunityId(id: Int, currentPage: Int, query: String) {
        interactor.getRecipesByCommunityID(
            request: .init(
                body: RecipesByCommunityIDRequestBody(
                    id: id,
                    limit: 2,
                    currentPage: currentPage,
                    query: query
                )
            )
        )
    }

    func getEverything(query: String) {
        interactor.getEverything(request: .init(query: query))
    }

    func getSavedRecipes(currentPage: Int, query: String) {
        interactor.getSavedRecipes(request: .init(query: query, currentPage: currentPage))
    }

    func getRecipes(currentPage: Int, query: String) {
        interactor.getRecipes(request: .init(query: query, currentPage: currentPage))
    }

    func getCommunities(currentPage: Int, query: String) {
        interactor.getCommunities(request: .init(query: query, currentPage: currentPage))
    }
}
