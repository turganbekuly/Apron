//
//  MyRecipesDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models

enum MyRecipesDataFlow {}

extension MyRecipesDataFlow {
    enum GetMyRecipesData {
        struct Request {

        }
        struct Response {
            let result: MyRecipesResults
        }
        struct ViewModel {
            var state: MyRecipesViewController.State
        }
    }

    enum MyRecipesResults {
        case successful(User)
        case failed(AKNetworkError)
    }
}
