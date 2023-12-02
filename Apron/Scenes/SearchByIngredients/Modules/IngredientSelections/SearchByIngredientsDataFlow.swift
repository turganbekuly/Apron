//
//  SearchByIngredientsDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models

enum SearchByIngredientsDataFlow { }

extension SearchByIngredientsDataFlow {
    enum GetProductsByIDs {
        struct Request {
            let ids: [Int]
        }
        struct Response {
            let result: GetProductsByIDsResult
        }
        struct ViewModel {
            var state: SearchByIngredientsViewController.State
        }
    }
    
    enum GetProductsByIDsResult {
        case success(model: [Product])
        case error(error: AKNetworkError)
    }
}

extension SearchByIngredientsDataFlow {
    enum GetProductsByName {
        struct Request {
            let name: String
        }
        struct Response {
            let result: GetProductsByNameResult
        }
        struct ViewModel {
            var state: SearchByIngredientsViewController.State
        }
    }
    
    enum GetProductsByNameResult {
        case success(model: [Product])
        case error(error: AKNetworkError)
    }
}
