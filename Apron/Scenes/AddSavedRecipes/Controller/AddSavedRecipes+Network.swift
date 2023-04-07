//
//  AddSavedRecipes+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

extension AddSavedRecipesViewController {

    // MARK: - Network

    func getSavedRecipes(page: Int) {
        interactor.getSavedRecipes(request: .init(page: page))
    }

    func addToCommunity(communityID: Int, recipes: [Int]) {
        interactor.addRecipesToCommunity(
            request: .init(communityId: communityID, recipes: recipes)
        )
    }
}
