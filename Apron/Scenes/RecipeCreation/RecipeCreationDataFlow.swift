//
//  RecipeCreationDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

enum RecipeCreationDataFlow {
    
}

extension RecipeCreationDataFlow {
    // MARK: - Create Recipe

    enum CreateRecipe {
        struct Request {
            let recipeCreation: RecipeCreation
        }
        struct Response {
            let result: CreateRecipeResult
        }
        struct ViewModel {
            var state: RecipeCreationViewController.State
        }
    }

    enum CreateRecipeResult {
        case successful(model: RecipeResponse)
        case failed(error: AKNetworkError)
    }
}
