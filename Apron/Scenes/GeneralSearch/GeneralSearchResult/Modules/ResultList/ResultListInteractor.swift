//
//  ResultListInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol ResultListBusinessLogic {
    func getRecipesByCommunityID(
        request: ResultListDataFlow.GetRecipesByCommunityID.Request
    )
    func getEverything(
        request: ResultListDataFlow.GetEverything.Request
    )
    func getSavedRecipes(
        request: ResultListDataFlow.GetSavedRecipes.Request
    )
    func getRecipes(
        request: ResultListDataFlow.GetRecipes.Request
    )
    func getCommunities(
        request: ResultListDataFlow.GetCommunities.Request
    )
    func saveRecipe(request: ResultListDataFlow.SaveRecipe.Request)
    func joinCommunity(request: ResultListDataFlow.JoinCommunity.Request)
}

final class ResultListInteractor: ResultListBusinessLogic {

    // MARK: - Properties
    private let presenter: ResultListPresentationLogic
    private let provider: ResultListProviderProtocol
    
    // MARK: - Initialization
    init(presenter: ResultListPresentationLogic,
         provider: ResultListProviderProtocol = ResultListProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - ResultListBusinessLogic

    func getRecipesByCommunityID(request: ResultListDataFlow.GetRecipesByCommunityID.Request) {
        provider.getRecipesByCommunityID(request: request) { [weak self] in
            switch $0 {
            case let .successful(model: model):
                self?.presenter.getRecipesByCommunityID(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.getRecipesByCommunityID(response: .init(result: .failed(error: error)))
            }
        }
    }

    func getEverything(request: ResultListDataFlow.GetEverything.Request) {
        provider.getEverything(request: request) { [weak self] in
            switch $0 {
            case let .successful(model: model):
                self?.presenter.getEverything(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.getEverything(response: .init(result: .failed(error: error)))
            }
        }
    }

    func getSavedRecipes(request: ResultListDataFlow.GetSavedRecipes.Request) {
        provider.getSavedRecipes(request: request) { [weak self] in
            switch $0 {
            case let .successful(model: model):
                self?.presenter.getSavedRecipes(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.getSavedRecipes(response: .init(result: .failed(error: error)))
            }
        }
    }

    func getRecipes(request: ResultListDataFlow.GetRecipes.Request) {
        provider.getRecipes(request: request) { [weak self] in
            switch $0 {
            case let .successful(model: model):
                self?.presenter.getRecipes(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.getRecipes(response: .init(result: .failed(error: error)))
            }
        }
    }

    func getCommunities(request: ResultListDataFlow.GetCommunities.Request) {
        provider.getCommunities(request: request) { [weak self] in
            switch $0 {
            case let .successful(model: model):
                self?.presenter.getCommunities(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.getCommunities(response: .init(result: .failed(error: error)))
            }
        }
    }

    func saveRecipe(request: ResultListDataFlow.SaveRecipe.Request) {
        provider.saveRecipe(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.saveRecipe(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.saveRecipe(response: .init(result: .failed(error: error)))
            }
        }
    }

    func joinCommunity(request: ResultListDataFlow.JoinCommunity.Request) {
        provider.joinCommunity(request: request) { [weak self] in
            switch $0 {
            case .successfull:
                self?.presenter.joinCommunity(response: .init(result: .successfull))
            case let .failed(error):
                self?.presenter.joinCommunity(response: .init(result: .failed(error: error)))
            }
        }
    }
}
