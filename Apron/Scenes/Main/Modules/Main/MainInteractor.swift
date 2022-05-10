//
//  MainInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol MainBusinessLogic {
    func joinCommunity(request: MainDataFlow.JoinCommunity.Request)
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
}
