//
//  AuthorizationService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.05.2022.
//

import AKNetwork

protocol AuthorizationServiceProtocol {
    func login(
        request: AuthorizationDataFlow.Login.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class AuthorizationService: AuthorizationServiceProtocol {

    // MARK: - Properties
    private let provider: AKNetworkProvider<AuthorizationEndpoints>

    // MARK: - Init
    init(provider: AKNetworkProvider<AuthorizationEndpoints>) {
        self.provider = provider
    }

    // MARK: - RecipeCreationServiceProtocol

    func login(
        request: AuthorizationDataFlow.Login.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .login(
            email: request.email,
            password: request.password
        )) { result in
            completion(result)
        }
    }
}

