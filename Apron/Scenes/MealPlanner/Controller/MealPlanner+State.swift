//
//  MealPlanner+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models
import UIKit

extension MealPlannerViewController {

    // MARK: - State
    public enum State {
        case initial
        case getRecipesSucceed([MealPlannerResponse])
        case getRecipesFailed(AKNetworkError)
        case saveRecipeSucceed
        case saveRecipeFailed(AKNetworkError)
        case removeRecipeSucceed
        case removeRecipeFailed(AKNetworkError)
    }

    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            break
        case let .getRecipesSucceed(planner):
            isLoadingButton(false)
            self.mealPlannerRecipes = planner
        case .getRecipesFailed(_):
            isLoadingButton(false)
            sections = [
                .init(section: .monday(.monday), rows: [.monday(nil)]),
                .init(section: .tuesday(.tuesday), rows: [.tuesday(nil)]),
                .init(section: .wednesday(.wednesday), rows: [.wednesday(nil)]),
                .init(section: .thursday(.thursday), rows: [.thursday(nil)]),
                .init(section: .friday(.friday), rows: [.friday(nil)]),
                .init(section: .saturday(.saturday), rows: [.saturday(nil)]),
                .init(section: .sunday(.sunday), rows: [.sunday(nil)]),
            ]
        case .saveRecipeSucceed:
            getRecipes(
                startDate: dateConverter(date: startDate),
                endDate: dateConverter(date: endDate)
            )
        case .saveRecipeFailed(_):
            isLoadingButton(false)
        case .removeRecipeSucceed:
            getRecipes(
                startDate: dateConverter(date: startDate),
                endDate: dateConverter(date: endDate)
            )
        case .removeRecipeFailed(_):
            isLoadingButton(false)
        }
    }

}
