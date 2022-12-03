//
//  RecipeSearch+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

extension RecipeSearchViewController {
    
    // MARK: - Network

    func getRecipes(currentPage: Int, query: String) {
        var filter = SearchFilterRequestBody()
        filter.page = currentPage
        filter.query = query
        filter.limit = 20
        interactor.getRecipes(request: .init(body: filter))
    }

    func saveRecipe(with id: Int) {
        interactor.saveRecipe(request: .init(id: id))
    }
}
