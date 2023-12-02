//
//  SearchByIngredientsResultInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

protocol SearchByIngredientsResultBusinessLogic {
    func getRecipesByIngredients(request: SearchByIngredientsResultDataFlow.GetRecipesByIngredients.Request)
}

final class SearchByIngredientsResultInteractor: SearchByIngredientsResultBusinessLogic {
    
    // MARK: - Properties
    private let presenter: SearchByIngredientsResultPresentationLogic
    private let provider: SearchByIngredientsResultProviderProtocol
    
    // MARK: - Initialization
    init(presenter: SearchByIngredientsResultPresentationLogic,
         provider: SearchByIngredientsResultProviderProtocol = SearchByIngredientsResultProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - SearchByIngredientsResultBusinessLogic

    func getRecipesByIngredients(request: SearchByIngredientsResultDataFlow.GetRecipesByIngredients.Request) {
        provider.getRecipesByIngredients(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.getRecipesByIngredients(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.getRecipesByIngredients(response: .init(result: .failed(error: error)))
            }
        }
    }
}
