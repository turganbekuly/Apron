//
//  MainInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol MainBusinessLogic {
    func joinCommunity(request: MainDataFlow.JoinCommunity.Request)
    func getCommunitiesByCategory(request: MainDataFlow.GetCommunities.Request)
    func getMyCommunities(request: MainDataFlow.GetMyCommunities.Request)
}

final class MainInteractor: MainBusinessLogic {
    
    // MARK: - Properties
    private let presenter: MainPresentationLogic
    private let provider: MainProviderProtocol
    
    // MARK: - Initialization
    init(
        presenter: MainPresentationLogic,
        provider: MainProviderProtocol = MainProvider()
    ) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - MainBusinessLogic

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

    func getCommunitiesByCategory(request: MainDataFlow.GetCommunities.Request) {
        provider.getCommunitiesByCategory(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.getCommunitiesByCategory(
                    response: .init(result: .successful(model: model))
                )
            case let .failed(error):
                self?.presenter.getCommunitiesByCategory(
                    response: .init(result: .failed(error: error))
                )
            }
        }
    }

    func getMyCommunities(request: MainDataFlow.GetMyCommunities.Request) {
        provider.getMyCommunities(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.getMyCommunities(
                    response: .init(result: .successful(model: model))
                )
            case let .failed(error):
                self?.presenter.getMyCommunities(
                    response: .init(result: .failed(error: error))
                )
            }
        }
    }
}
