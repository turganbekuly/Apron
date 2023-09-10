//
//  SearchByIngredientsResultDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models

enum SearchByIngredientsResultDataFlow {
    
}

extension SearchByIngredientsResultDataFlow {
    enum GetRecipesByIngredients {
        struct Request {
            let body: SearchByIngredientsResult
        }
        struct Response {
            let result: GetRecipesByIngredientsResult
        }
        struct ViewModel {
            var state: SearchByIngredientsResultViewController.State
        }
    }

    enum GetRecipesByIngredientsResult {
        case successful(model: [RecipeResponse])
        case failed(error: AKNetworkError)
    }
}
