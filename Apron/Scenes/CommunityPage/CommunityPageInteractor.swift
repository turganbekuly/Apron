//
//  CommunityPageInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol CommunityPageBusinessLogic {
    func getCommunity(request: CommunityPageDataFlow.GetCommunity.Request)
    func joinCommunity(request: MainDataFlow.JoinCommunity.Request)
}

final class CommunityPageInteractor: CommunityPageBusinessLogic {
    
    // MARK: - Properties
    private let presenter: CommunityPagePresentationLogic
    private let provider: CommunityPageProviderProtocol
    
    // MARK: - Initialization
    init(presenter: CommunityPagePresentationLogic,
         provider: CommunityPageProviderProtocol = CommunityPageProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - CommunityPageBusinessLogic

    func getCommunity(request: CommunityPageDataFlow.GetCommunity.Request) {
        provider.getCommunity(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.getCommunity(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.getCommunity(response: .init(result: .failed(error: error)))
            }
        }
    }

    func joinCommunity(request: MainDataFlow.JoinCommunity.Request) {
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
