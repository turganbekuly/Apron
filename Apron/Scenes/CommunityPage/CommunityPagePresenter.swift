//
//  CommunityPagePresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol CommunityPagePresentationLogic: AnyObject {
    func getCommunity(response: CommunityPageDataFlow.GetCommunity.Response)
    func joinCommunity(response: CommunityPageDataFlow.JoinCommunity.Response)
    func getRecipesByCommunity(response: CommunityPageDataFlow.GetRecipesByCommunity.Response)
    func saveRecipe(response: CommunityPageDataFlow.SaveRecipe.Response)
}

final class CommunityPagePresenter: CommunityPagePresentationLogic {
    
    // MARK: - Properties
    weak var viewController: CommunityPageDisplayLogic?
    
    // MARK: - CommunityPagePresentationLogic

    func getCommunity(response: CommunityPageDataFlow.GetCommunity.Response) {
        DispatchQueue.main.async {
            var viewModel: CommunityPageDataFlow.GetCommunity.ViewModel

            defer { self.viewController?.displayCommunity(viewModel: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .displayCommunity(model))
            case let .failed(error):
                viewModel = .init(state: .displayCommunityError(error))
            }
        }
    }

    func joinCommunity(response: CommunityPageDataFlow.JoinCommunity.Response) {
        DispatchQueue.main.async {
            var viewModel: CommunityPageDataFlow.JoinCommunity.ViewModel

            defer { self.viewController?.displayJoinCommunity(viewModel: viewModel) }

            switch response.result {
            case .successfull:
                viewModel = .init(state: .joinedCommunity)
            case .failed:
                viewModel = .init(state: .joinedCommunityFailed)
            }
        }
    }

    func getRecipesByCommunity(response: CommunityPageDataFlow.GetRecipesByCommunity.Response) {
        DispatchQueue.main.async {
            var viewModel: CommunityPageDataFlow.GetRecipesByCommunity.ViewModel

            defer { self.viewController?.displayRecipesByCommunity(viewModel: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .displayRecipes(model))
            case let .failed(error):
                viewModel = .init(state: .displayRecipesFailed(error))
            }
        }
    }

    func saveRecipe(response: CommunityPageDataFlow.SaveRecipe.Response) {
        DispatchQueue.main.async {
            var viewModel: CommunityPageDataFlow.SaveRecipe.ViewModel

            defer { self.viewController?.displaySaveRecipe(viewModel: viewModel) }

            switch response.result {
            case let .successful(count):
                viewModel = .init(state: .saveRecipe(count))
            case let .failed(error):
                viewModel = .init(state: .saveRecipeFailed(error))
            }
        }
    }
}
