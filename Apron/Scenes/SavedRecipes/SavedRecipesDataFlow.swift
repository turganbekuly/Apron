//
//  SavedRecipesDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

enum SavedRecipesDataFlow {

}

extension SavedRecipesDataFlow {
    enum GetSavedRecipe {
        struct Request {
            let page: Int
        }
        struct Response {
            let result: GetSavedRecipeResult
        }
        struct ViewModel {
            var state: SavedRecipesViewController.State
        }
    }

    enum GetSavedRecipeResult {
        case successful(model: [RecipeResponse])
        case failed(error: AKNetworkError)
    }
}
