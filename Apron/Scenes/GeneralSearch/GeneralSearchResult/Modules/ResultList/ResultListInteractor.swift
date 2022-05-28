//
//  ResultListInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol ResultListBusinessLogic {
    func getRecipesByCommunityID(
        request: ResultListDataFlow.GetRecipesByCommunityID.Request
    )
}

final class ResultListInteractor: ResultListBusinessLogic {
    
    // MARK: - Properties
    private let presenter: ResultListPresentationLogic
    private let provider: ResultListProviderProtocol
    
    // MARK: - Initialization
    init(presenter: ResultListPresentationLogic,
         provider: ResultListProviderProtocol = ResultListProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - ResultListBusinessLogic

    func getRecipesByCommunityID(request: ResultListDataFlow.GetRecipesByCommunityID.Request) {
        provider.getRecipesByCommunityID(request: request) { [weak self] in
            switch $0 {
            case let .successful(model: model):
                self?.presenter.getRecipesByCommunityID(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.getRecipesByCommunityID(response: .init(result: .failed(error: error)))
            }
        }
    }
}
