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

    func getRecipes(filters: SearchFilterRequestBody) {
        interactor.getRecipes(request: .init(body: filters))
    }

    func saveRecipe(with id: Int) {
        interactor.saveRecipe(request: .init(id: id))
    }
}
