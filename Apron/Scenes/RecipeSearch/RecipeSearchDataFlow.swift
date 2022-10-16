//
//  RecipeSearchDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import AKNetwork

enum RecipeSearchDataFlow {}

extension RecipeSearchDataFlow {
    enum GetRecipes {
        struct Request {
            let body: SearchByQueryRequestBody
        }
        struct Response {
            let result: GetRecipesResult
        }
        struct ViewModel {
            var state: RecipeSearchViewController.State
        }
    }

    enum GetRecipesResult {
        case successful(model: [RecipeResponse])
        case failed(error: AKNetworkError)
    }
}

extension RecipeSearchDataFlow {
    enum SaveRecipe {
        struct Request {
            let id: Int
        }
        struct Response {
            let result: SaveRecipeResult
        }
        struct ViewModel {
            var state: RecipeSearchViewController.State
        }
    }

    enum SaveRecipeResult {
        case successful(model: RecipeResponse)
        case failed(error: AKNetworkError)
    }
}
