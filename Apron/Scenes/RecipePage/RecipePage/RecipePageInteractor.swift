//
//  RecipePageInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol RecipePageBusinessLogic {
    func getRecipe(request: RecipePageDataFlow.GetRecipe.Request)
    func rateRecipe(request: RecipePageDataFlow.RateRecipe.Request)
}

final class RecipePageInteractor: RecipePageBusinessLogic {
    
    // MARK: - Properties
    private let presenter: RecipePagePresentationLogic
    private let provider: RecipePageProviderProtocol
    
    // MARK: - Initialization
    init(presenter: RecipePagePresentationLogic,
         provider: RecipePageProviderProtocol = RecipePageProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - RecipePageBusinessLogic

    func getRecipe(request: RecipePageDataFlow.GetRecipe.Request) {
        provider.getRecipe(request: request) { [weak self] in
            switch $0 {
            case let .successfull(model):
                self?.presenter.getRecipe(response: .init(result: .successfull(model: model)))
            case let .failed(error):
                self?.presenter.getRecipe(response: .init(result: .failed(error: error)))
            }
        }
    }

    func rateRecipe(request: RecipePageDataFlow.RateRecipe.Request) {
        provider.rateRecipe(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.rateRecipe(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.rateRecipe(response: .init(result: .failed(error: error)))
            }
        }
    }
}
