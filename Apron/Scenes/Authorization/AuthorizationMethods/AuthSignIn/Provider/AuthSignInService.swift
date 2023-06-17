//
//  AuthSignInService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//



protocol AuthSignInServiceProtocol {
    func login(
        request: AuthSignInDataFlow.Login.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class AuthSignInService: AuthSignInServiceProtocol {

    // MARK: - Properties
    private let provider: AKNetworkProvider<AuthSignInEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<AuthSignInEndpoint>) {
        self.provider = provider
    }

    // MARK: - AuthSignInServiceProtocol

    func login(
        request: AuthSignInDataFlow.Login.Request,
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
