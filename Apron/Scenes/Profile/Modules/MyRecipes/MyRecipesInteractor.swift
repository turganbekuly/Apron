//
//  MyRecipesInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

protocol MyRecipesBusinessLogic {
    func getProfileRecipes(request: MyRecipesDataFlow.GetMyRecipesData.Request)
}

final class MyRecipesInteractor: MyRecipesBusinessLogic {
    
    // MARK: - Properties
    private let presenter: MyRecipesPresentationLogic
    private let provider: MyRecipesProviderProtocol
    
    // MARK: - Initialization
    init(presenter: MyRecipesPresentationLogic,
         provider: MyRecipesProviderProtocol = MyRecipesProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - MyRecipesBusinessLogic

    func getProfileRecipes(request: MyRecipesDataFlow.GetMyRecipesData.Request) {
        provider.getProfile(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.getProfileRecipes(response: .init(result: .successful(model)))
            case let .failed(error):
                self?.presenter.getProfileRecipes(response: .init(result: .failed(error)))
            }
        }
    }
}
