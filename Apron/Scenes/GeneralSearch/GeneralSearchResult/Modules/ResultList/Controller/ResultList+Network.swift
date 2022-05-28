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
}
