//
//  AuthorizationService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.05.2022.
//

import AKNetwork

protocol AuthorizationServiceProtocol {
    func login(
        request: AuthorizationDataFlow.AuthorizationWithApple.Request,
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
        request: AuthorizationDataFlow.AuthorizationWithApple.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .authByApple(code: request.code)) { result in
            completion(result)
        }
    }
}
