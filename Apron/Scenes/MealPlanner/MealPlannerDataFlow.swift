//
//  MealPlannerDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models

enum MealPlannerDataFlow {}

extension MealPlannerDataFlow {
    enum GetMealPlannerRecipes {
        struct Request {
            let startDate: String
            let endDate: String
        }
        struct Response {
            let result: MealPlannerRecipesResponse
        }
        struct ViewModel {
            var state: MealPlannerViewController.State
        }
    }

    enum MealPlannerRecipesResponse {
        case success([MealPlannerResponse])
        case error(AKNetworkError)
    }
}

extension MealPlannerDataFlow {
    enum MealPlannerRecipeOperation {
        struct Request {
            let body: MealPlannerRequestBody
        }
        struct Response {
            let result: MealPlannerRecipeOperationResponse
        }
        struct ViewModel {
            var state: MealPlannerViewController.State
        }
    }

    enum MealPlannerRecipeOperationResponse {
        case success
        case error(AKNetworkError)
    }
}
