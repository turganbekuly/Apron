//
//  ResultListDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

enum ResultListDataFlow {
    
}

extension ResultListDataFlow {
    enum GetRecipesByCommunityID {
        struct Request {
            let body: RecipesByCommunityIDRequestBody
        }
        struct Response {
            let result: GetRecipesByCommunityIDResult
        }
        struct ViewModel {
            var state: ResultListViewController.State
        }
    }

    enum GetRecipesByCommunityIDResult {
        case successful(model: [RecipeResponse])
        case failed(error: AKNetworkError)
    }
}
