//
//  RecipePageDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

enum RecipePageDataFlow {
    
}

extension RecipePageDataFlow {
    // MARK: - Get Recipe

    enum GetRecipe {
        struct Request {
            let id: Int
        }
        struct Response {
            let result: GetRecipeResult
        }
        struct ViewModel {
            var state: RecipePageViewController.State
        }
    }

    enum GetRecipeResult {
        case successfull(model: RecipeResponse)
        case failed(error: AKNetworkError)
    }
}

extension RecipePageDataFlow {
    enum RateRecipe {
        struct Request {
            let body: RatingRequestBody
        }
        struct Response {
            let result: RateRecipeResult
        }
        struct ViewModel {
            var state: RecipePageViewController.State
        }
    }

    enum RateRecipeResult {
        case successful(model: RatingResponse)
        case failed(error: AKNetworkError)
    }
}

extension RecipePageDataFlow {
    enum SaveRecipe {
        struct Request {
            let id: Int
        }
        struct Response {
            let result: SaveRecipeResult
        }
        struct ViewModel {
            var state: RecipePageViewController.State
        }
    }

    enum SaveRecipeResult {
        case successful(model: RecipeResponse)
        case failed(error: AKNetworkError)
    }
}

extension RecipePageDataFlow {
    enum GetComments {
        struct Request {
            let recipeId: Int
        }
        struct Response {
            let result: GetCommentsResult
        }
        struct ViewModel {
            var state: RecipePageViewController.State
        }
    }

    enum GetCommentsResult {
        case successful(model: [RecipeCommentResponse])
        case failed(error: AKNetworkError)
    }
}
