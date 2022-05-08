//
//  IngredientSelectionInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol IngredientSelectionBusinessLogic {
    func getProducts(request: IngredientSelectionDataFlow.GetProducts.Request)
}

final class IngredientSelectionInteractor: IngredientSelectionBusinessLogic {
    
    // MARK: - Properties
    private let presenter: IngredientSelectionPresentationLogic
    private let provider: IngredientSelectionProviderProtocol
    
    // MARK: - Initialization
    init(presenter: IngredientSelectionPresentationLogic,
         provider: IngredientSelectionProviderProtocol = IngredientSelectionProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - IngredientSelectionBusinessLogic

    func getProducts(request: IngredientSelectionDataFlow.GetProducts.Request) {
        provider.getProducts(request: request) { [weak self] in
            switch $0 {
            case let .successful(model: model):
                self?.presenter.getProducts(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.getProducts(response: .init(result: .failed(error: error)))
            }
        }
    }
}
