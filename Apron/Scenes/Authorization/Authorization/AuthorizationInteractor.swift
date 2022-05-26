//
//  AuthorizationInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.05.2022.
//

protocol AuthorizationBusinessLogic {
    func login(request: AuthorizationDataFlow.Login.Request)
}

final class AuthorizationInteractor: AuthorizationBusinessLogic {

    // MARK: - Properties
    private let presenter: AuthorizationPresentationLogic
    private let provider: AuthorizationProviderProtocol

    // MARK: - Initialization
    init(presenter: AuthorizationPresentationLogic,
         provider: AuthorizationProviderProtocol = AuthorizationProvider()) {
        self.presenter = presenter
        self.provider = provider
    }

    // MARK: - RecipeCreationBusinessLogic

    func login(request: AuthorizationDataFlow.Login.Request) {
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

