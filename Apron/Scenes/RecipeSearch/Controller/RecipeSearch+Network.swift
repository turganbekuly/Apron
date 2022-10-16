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
        interactor.getRecipes(request: .init(body: SearchByQueryRequestBody(
            currentPage: currentPage,
            limit: 20,
            name: query
        )))
    }

    func saveRecipe(with id: Int) {
        interactor.saveRecipe(request: .init(id: id))
    }
}
