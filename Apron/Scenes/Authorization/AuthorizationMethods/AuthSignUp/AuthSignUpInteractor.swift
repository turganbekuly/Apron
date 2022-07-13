//
//  AuthSignUpInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol AuthSignUpBusinessLogic {
    func signup(request: AuthSignUpDataFlow.SignUp.Request)
}

final class AuthSignUpInteractor: AuthSignUpBusinessLogic {
    
    // MARK: - Properties
    private let presenter: AuthSignUpPresentationLogic
    private let provider: AuthSignUpProviderProtocol
    
    // MARK: - Initialization
    init(presenter: AuthSignUpPresentationLogic,
         provider: AuthSignUpProviderProtocol = AuthSignUpProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - AuthSignUpBusinessLogic

    func signup(request: AuthSignUpDataFlow.SignUp.Request) {
        provider.signup(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.signup(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.signup(response: .init(result: .failed(error: error)))
            }
        }
    }
}
