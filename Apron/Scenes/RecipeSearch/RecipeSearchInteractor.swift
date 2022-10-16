//
//  RecipeSearchInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol RecipeSearchBusinessLogic {
    func getRecipes(
        request: RecipeSearchDataFlow.GetRecipes.Request
    )
    func saveRecipe(request: RecipeSearchDataFlow.SaveRecipe.Request)
}

final class RecipeSearchInteractor: RecipeSearchBusinessLogic {
    // MARK: - Properties
    private let presenter: RecipeSearchPresentationLogic
    private let provider: RecipeSearchProviderProtocol
    
    // MARK: - Initialization
    init(presenter: RecipeSearchPresentationLogic,
         provider: RecipeSearchProviderProtocol = RecipeSearchProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - RecipeSearchBusinessLogic

    func getRecipes(request: RecipeSearchDataFlow.GetRecipes.Request) {
        provider.getRecipes(request: request) { [weak self] in
            switch $0 {
            case let .successful(model: model):
                self?.presenter.getRecipes(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.getRecipes(response: .init(result: .failed(error: error)))
            }
        }
    }

    func saveRecipe(request: RecipeSearchDataFlow.SaveRecipe.Request) {
        provider.saveRecipe(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.saveRecipe(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.saveRecipe(response: .init(result: .failed(error: error)))
            }
        }
    }
}
