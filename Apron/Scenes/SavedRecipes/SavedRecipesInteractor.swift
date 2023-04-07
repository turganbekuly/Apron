//
//  SavedRecipesInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol SavedRecipesBusinessLogic {
    func getSavedRecipes(request: SavedRecipesDataFlow.GetSavedRecipe.Request)
}

final class SavedRecipesInteractor: SavedRecipesBusinessLogic {

    // MARK: - Properties
    private let presenter: SavedRecipesPresentationLogic
    private let provider: SavedRecipesProviderProtocol

    // MARK: - Initialization
    init(presenter: SavedRecipesPresentationLogic,
         provider: SavedRecipesProviderProtocol = SavedRecipesProvider()) {
        self.presenter = presenter
        self.provider = provider
    }

    // MARK: - SavedRecipesBusinessLogic

    func getSavedRecipes(request: SavedRecipesDataFlow.GetSavedRecipe.Request) {
        provider.getSavedRecipes(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.getSavedRecipes(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.getSavedRecipes(response: .init(result: .failed(error: error)))
            }
        }
    }
}
