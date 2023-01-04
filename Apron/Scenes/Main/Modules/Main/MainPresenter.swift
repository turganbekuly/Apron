//
//  MainPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol MainPresentationLogic: AnyObject {
    func getCommunitiesByCategory(response: MainDataFlow.GetCommunities.Response)
    func getCookNowRecipes(response: MainDataFlow.GetCookNowRecipes.Response)
    func getEventRecipes(response: MainDataFlow.GetEventRecipes.Response)
    func saveRecipe(response: MainDataFlow.SaveRecipe.Response)
}

final class MainPresenter: MainPresentationLogic {
    
    // MARK: - Properties
    weak var viewController: MainDisplayLogic?
    
    // MARK: - MainPresentationLogic

    func getCommunitiesByCategory(response: MainDataFlow.GetCommunities.Response) {
        DispatchQueue.main.async {
            var viewModel: MainDataFlow.GetCommunities.ViewModel

            defer { self.viewController?.displayCommunities(viewModel: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .fetchCommunitiesByCategory(model))
            case let .failed(error):
                viewModel = .init(state: .fetchCommunitiesByCategoryFailed(error))
            }
        }
    }

    func getCookNowRecipes(response: MainDataFlow.GetCookNowRecipes.Response) {
        DispatchQueue.main.async {
            var viewModel: MainDataFlow.GetCookNowRecipes.ViewModel

            defer { self.viewController?.displayCookNowRecipes(viewModel: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .fetchCookNowRecipes(model))
            case let .failed(error):
                viewModel = .init(state: .fetchCookNowRecipesFailed(error))
            }
        }
    }

    func getEventRecipes(response: MainDataFlow.GetEventRecipes.Response) {
        DispatchQueue.main.async {
            var viewModel: MainDataFlow.GetEventRecipes.ViewModel

            defer { self.viewController?.displayEventRecipes(viewModel: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .fetchEventRecipes(model))
            case let .failed(error):
                viewModel = .init(state: .fetchEventRecipesFailed(error))
            }
        }
    }

    func saveRecipe(response: MainDataFlow.SaveRecipe.Response) {
        DispatchQueue.main.async {
            var viewModel: MainDataFlow.SaveRecipe.ViewModel

            defer { self.viewController?.displaySavedRecipe(viewModel: viewModel) }

            switch response.result {
            case let .successful(recipe):
                viewModel = .init(state: .saveRecipe(recipe))
            case let .failed(error):
                viewModel = .init(state: .saveRecipeFailed(error))
            }
        }
    }
}
