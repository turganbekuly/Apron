//
//  AddSavedRecipesDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

enum AddSavedRecipesDataFlow {
    
}

extension AddSavedRecipesDataFlow {
    enum GetSavedRecipe {
        struct Request {
            let page: Int
        }
        struct Response {
            let result: GetSavedRecipeResult
        }
        struct ViewModel {
            var state: AddSavedRecipesViewController.State
        }
    }

    enum GetSavedRecipeResult {
        case successful(model: [RecipeResponse])
        case failed(error: AKNetworkError)
    }
}

extension AddSavedRecipesDataFlow {
    enum AddToCommunity {
        struct Request {
            let communityId: Int
            let recipes: [Int]
        }
        struct Response {
            let result: AddToCommunityResponse
        }
        struct ViewModel {
            var state: AddSavedRecipesViewController.State
        }
    }

    enum AddToCommunityResponse {
        case successful
        case failed(error: AKNetworkError)
    }
}
