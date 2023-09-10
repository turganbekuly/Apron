//
//  SearchByIngredientsInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

protocol SearchByIngredientsBusinessLogic {
    func getProductsByIds(request: SearchByIngredientsDataFlow.GetProductsByIDs.Request)
    func getProductsByName(request: SearchByIngredientsDataFlow.GetProductsByName.Request)
}

final class SearchByIngredientsInteractor: SearchByIngredientsBusinessLogic {
    
    // MARK: - Properties
    private let presenter: SearchByIngredientsPresentationLogic
    private let provider: SearchByIngredientsProviderProtocol
    
    // MARK: - Initialization
    init(presenter: SearchByIngredientsPresentationLogic,
         provider: SearchByIngredientsProviderProtocol = SearchByIngredientsProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - SearchByIngredientsBusinessLogic

    func getProductsByIds(request: SearchByIngredientsDataFlow.GetProductsByIDs.Request) {
        provider.getProductsByIds(request: request) { [weak self] in
            switch $0 {
            case let .success(model: model):
                self?.presenter.getProductsByIds(response: .init(result: .success(model: model)))
            case let .error(error):
                self?.presenter.getProductsByIds(response: .init(result: .error(error: error)))
            }
        }
    }
    
    func getProductsByName(request: SearchByIngredientsDataFlow.GetProductsByName.Request) {
        provider.getProductsByName(request: request) { [weak self] in
            switch $0 {
            case let .success(model: model):
                self?.presenter.getProductsByName(response: .init(result: .success(model: model)))
            case let .error(error):
                self?.presenter.getProductsByName(response: .init(result: .error(error: error)))
            }
        }
    }
}
