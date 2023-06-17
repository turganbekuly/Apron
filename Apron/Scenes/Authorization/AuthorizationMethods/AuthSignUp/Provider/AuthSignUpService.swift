//
//  AuthSignUpService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//



protocol AuthSignUpServiceProtocol {
    func signup(
        request: AuthSignUpDataFlow.SignUp.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class AuthSignUpService: AuthSignUpServiceProtocol {

    // MARK: - Properties
    private let provider: AKNetworkProvider<AuthSignUpEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<AuthSignUpEndpoint>) {
        self.provider = provider
    }

    // MARK: - AuthSignUpServiceProtocol

    func signup(
        request: AuthSignUpDataFlow.SignUp.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .signup(body: request.body)) { result in
            completion(result)
        }
    }
}
