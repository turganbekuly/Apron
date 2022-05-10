//
//  CategorySelectionDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

enum CategorySelectionDataFlow {
    
}

extension CategorySelectionDataFlow {
    enum GetCategories {
        struct Request {

        }
        struct Response {
            let result: GetCategoriesResult
        }
        struct ViewModel {
            var state: CategorySelectionViewController.State
        }
    }

    enum GetCategoriesResult {
        case successful
        case failed(error: AKNetworkError)
    }
}
