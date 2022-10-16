//
//  CategorySelectionInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol CategorySelectionBusinessLogic {
    func getCategories(request: CategorySelectionDataFlow.GetCategories.Request)
}

final class CategorySelectionInteractor: CategorySelectionBusinessLogic {
    
    // MARK: - Properties
    private let presenter: CategorySelectionPresentationLogic
    private let provider: CategorySelectionProviderProtocol
    
    // MARK: - Initialization
    init(presenter: CategorySelectionPresentationLogic,
         provider: CategorySelectionProviderProtocol = CategorySelectionProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - CategorySelectionBusinessLogic

    func getCategories(request: CategorySelectionDataFlow.GetCategories.Request) {
        provider.getCategories(request: request) {
            switch $0 {
            case let .successful(model):
                self.presenter.getCategories(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self.presenter.getCategories(response: .init(result: .failed(error: error)))
            }
        }
    }
}
