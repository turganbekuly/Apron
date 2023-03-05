//
//  AddSavedRecipesInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 11/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol AddSavedRecipesBusinessLogic {
    func getSavedRecipes(request: AddSavedRecipesDataFlow.GetSavedRecipe.Request)
    func addRecipesToCommunity(request: AddSavedRecipesDataFlow.AddToCommunity.Request)
}

final class AddSavedRecipesInteractor: AddSavedRecipesBusinessLogic {

    // MARK: - Properties
    private let presenter: AddSavedRecipesPresentationLogic
    private let provider: AddSavedRecipesProviderProtocol

    // MARK: - Initialization
    init(presenter: AddSavedRecipesPresentationLogic,
         provider: AddSavedRecipesProviderProtocol = AddSavedRecipesProvider()) {
        self.presenter = presenter
        self.provider = provider
    }

    // MARK: - AddSavedRecipesBusinessLogic

    func getSavedRecipes(request: AddSavedRecipesDataFlow.GetSavedRecipe.Request) {
        provider.getSavedRecipes(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.getSavedRecipes(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.getSavedRecipes(response: .init(result: .failed(error: error)))
            }
        }
    }

    func addRecipesToCommunity(request: AddSavedRecipesDataFlow.AddToCommunity.Request) {
        provider.addRecipesToCommunity(request: request) { [weak self] in
            switch $0 {
            case .successful:
                self?.presenter.addRecipesToCommunity(response: .init(result: .successful))
            case let .failed(error):
                self?.presenter.addRecipesToCommunity(response: .init(result: .failed(error: error)))
            }
        }
    }
}
