//
//  CommunitiesListInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol CommunitiesListBusinessLogic {
    func getCommunities(request: CommunitiesListDataFlow.GetCommunities.Request)
    func joinCommunity(request: CommunitiesListDataFlow.JoinCommunity.Request)
}

final class CommunitiesListInteractor: CommunitiesListBusinessLogic {
    
    // MARK: - Properties
    private let presenter: CommunitiesListPresentationLogic
    private let provider: CommunitiesListProviderProtocol
    
    // MARK: - Initialization
    init(presenter: CommunitiesListPresentationLogic,
         provider: CommunitiesListProviderProtocol = CommunitiesListProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - CommunitiesListBusinessLogic

    func getCommunities(request: CommunitiesListDataFlow.GetCommunities.Request) {
        provider.getCommunities(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.getCommunities(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.getCommunities(response: .init(result: .failed(error: error)))
            }
        }
    }

    func joinCommunity(request: CommunitiesListDataFlow.JoinCommunity.Request) {
        provider.joinCommunity(request: request) { [weak self] in
            switch $0 {
            case .successfull:
                self?.presenter.joinCommunity(response: .init(result: .successfull))
            case let .failed(error):
                self?.presenter.joinCommunity(response: .init(result: .failed(error: error)))
            }
        }
    }
}
