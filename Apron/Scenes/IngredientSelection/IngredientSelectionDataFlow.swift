//
//  IngredientSelectionDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

enum IngredientSelectionDataFlow {
    
}

extension IngredientSelectionDataFlow {
    enum GetProducts {
        struct Request {
            let query: String
        }
        struct Response {
            let result: GetProductsResult
        }
        struct ViewModel {
            var state: IngredientSelectionViewController.State
        }
    }

    enum GetProductsResult {
        case successful(model: [Product])
        case failed(error: AKNetworkError)
    }
}
