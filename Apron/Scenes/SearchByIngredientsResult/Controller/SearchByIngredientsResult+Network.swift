//
//  SearchByIngredientsResult+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

extension SearchByIngredientsResultViewController {
    
    // MARK: - Network

    func getRecipes(with body: SearchByIngredientsResult) {
        interactor.getRecipesByIngredients(request: .init(body: body))
    }
}

struct SearchByIngredientsResult: Codable {
    let productIds: [String]
    let size: Int
}
