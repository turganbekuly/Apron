//
//  ResultListPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol ResultListPresentationLogic: AnyObject {
    func getRecipesByCommunityID(
        response: ResultListDataFlow.GetRecipesByCommunityID.Response
    )
    func getEverything(
        response: ResultListDataFlow.GetEverything.Response
    )
    func getSavedRecipes(
        response: ResultListDataFlow.GetSavedRecipes.Response
    )
    func getRecipes(
        response: ResultListDataFlow.GetRecipes.Response
    )
    func getCommunities(
        response: ResultListDataFlow.GetCommunities.Response
    )
}

final class ResultListPresenter: ResultListPresentationLogic {
    
    // MARK: - Properties
    weak var viewController: ResultListDisplayLogic?
    
    // MARK: - ResultListPresentationLogic

    func getRecipesByCommunityID(response: ResultListDataFlow.GetRecipesByCommunityID.Response) {
        DispatchQueue.main.async {
            var viewModel: ResultListDataFlow.GetRecipesByCommunityID.ViewModel

            defer { self.viewController?.displayRecipesByCommunityID(with: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .fetchRecipesByCommunityId(model))
            case let .failed(error):
                viewModel = .init(state: .fetchRecipesByCommunityIdFailed(error))
            }
        }
    }

    func getEverything(response: ResultListDataFlow.GetEverything.Response) {
        DispatchQueue.main.async {
            var viewModel: ResultListDataFlow.GetEverything.ViewModel

            defer { self.viewController?.displayEverything(with: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .fetchEverything(model))
            case let .failed(error):
                viewModel = .init(state: .fetchEverythingFailed(error))
            }
        }
    }

    func getSavedRecipes(response: ResultListDataFlow.GetSavedRecipes.Response) {
        DispatchQueue.main.async {
            var viewModel: ResultListDataFlow.GetSavedRecipes.ViewModel

            defer { self.viewController?.displaySavedRecipes(with: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .fetchSavedRecipes(model))
            case let .failed(error):
                viewModel = .init(state: .fetchSavedRecipesFailed(error))
            }
        }
    }

    func getRecipes(response: ResultListDataFlow.GetRecipes.Response) {
        DispatchQueue.main.async {
            var viewModel: ResultListDataFlow.GetRecipes.ViewModel

            defer { self.viewController?.displayRecipes(with: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .fetchRecipes(model))
            case let .failed(error):
                viewModel = .init(state: .fetchRecipesFailed(error))
            }
        }
    }

    func getCommunities(response: ResultListDataFlow.GetCommunities.Response) {
        DispatchQueue.main.async {
            var viewModel: ResultListDataFlow.GetCommunities.ViewModel

            defer { self.viewController?.displayCommunities(with: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .fetchCommunities(model))
            case let .failed(error):
                viewModel = .init(state: .fetchCommunitiesFailed(error))
            }
        }
    }
}
