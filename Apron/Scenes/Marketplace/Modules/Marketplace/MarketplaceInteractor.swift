//
//  MarketplaceInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

protocol MarketplaceBusinessLogic {
    func getItems(request: MarketplaceDataFlow.GetProducts.Request)
}

final class MarketplaceInteractor: MarketplaceBusinessLogic {
    
    // MARK: - Properties
    private let presenter: MarketplacePresentationLogic
    private let provider: MarketplaceProviderProtocol
    
    // MARK: - Initialization
    init(presenter: MarketplacePresentationLogic,
         provider: MarketplaceProviderProtocol = MarketplaceProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - MarketplaceBusinessLogic

    func getItems(request: MarketplaceDataFlow.GetProducts.Request) {
        provider.getProducts(request: request) { [weak self] in
            switch $0 {
            case let .success(model):
                self?.presenter.getItems(response: .init(result: .success(model)))
            case let .error(error):
                self?.presenter.getItems(response: .init(result: .error(error)))
            }
        }
    }
}
