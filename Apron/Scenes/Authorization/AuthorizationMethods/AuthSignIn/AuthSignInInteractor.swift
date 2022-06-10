//
//  AuthSignInInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol AuthSignInBusinessLogic {
    func login(request: AuthSignInDataFlow.Login.Request)
}

final class AuthSignInInteractor: AuthSignInBusinessLogic {
    
    // MARK: - Properties
    private let presenter: AuthSignInPresentationLogic
    private let provider: AuthSignInProviderProtocol
    
    // MARK: - Initialization
    init(presenter: AuthSignInPresentationLogic,
         provider: AuthSignInProviderProtocol = AuthSignInProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - AuthSignInBusinessLogic

    func login(request: AuthSignInDataFlow.Login.Request) {
        provider.login(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.login(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.login(response: .init(result: .failed(error: error)))
            }
        }
    }
}
