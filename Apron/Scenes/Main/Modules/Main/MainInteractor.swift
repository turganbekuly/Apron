//
//  MainInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol MainBusinessLogic {
    func getCommunitiesByCategory(request: MainDataFlow.GetCommunities.Request)
    func getCookNowRecipes(request: MainDataFlow.GetCookNowRecipes.Request)
//    func getMyCommunities(request: MainDataFlow.GetMyCommunities.Request)
    func saveRecipe(request: MainDataFlow.SaveRecipe.Request)
}

final class MainInteractor: MainBusinessLogic {
    
    // MARK: - Properties
    private let presenter: MainPresentationLogic
    private let provider: MainProviderProtocol
    
    // MARK: - Initialization
    init(
        presenter: MainPresentationLogic,
        provider: MainProviderProtocol = MainProvider()
    ) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - MainBusinessLogic

    func getCommunitiesByCategory(request: MainDataFlow.GetCommunities.Request) {
        provider.getCommunitiesByCategory(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.getCommunitiesByCategory(
                    response: .init(result: .successful(model: model))
                )
            case let .failed(error):
                self?.presenter.getCommunitiesByCategory(
                    response: .init(result: .failed(error: error))
                )
            }
        }
    }

    func getCookNowRecipes(request: MainDataFlow.GetCookNowRecipes.Request) {
        provider.getCookNowRecipes(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.getCookNowRecipes(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.getCookNowRecipes(response: .init(result: .failed(error: error)))
            }
        }
    }

    func saveRecipe(request: MainDataFlow.SaveRecipe.Request) {
        provider.saveRecipe(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.saveRecipe(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.saveRecipe(response: .init(result: .failed(error: error)))
            }
        }
    }

//    func getMyCommunities(request: MainDataFlow.GetMyCommunities.Request) {
//        provider.getMyCommunities(request: request) { [weak self] in
//            switch $0 {
//            case let .successful(model):
//                self?.presenter.getMyCommunities(
//                    response: .init(result: .successful(model: model))
//                )
//            case let .failed(error):
//                self?.presenter.getMyCommunities(
//                    response: .init(result: .failed(error: error))
//                )
//            }
//        }
//    }
}
