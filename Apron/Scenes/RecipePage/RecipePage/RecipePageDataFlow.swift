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
