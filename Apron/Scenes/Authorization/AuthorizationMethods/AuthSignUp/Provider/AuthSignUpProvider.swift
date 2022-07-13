//
//  AuthSignUpProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork
import Models

protocol AuthSignUpProviderProtocol {
    func signup(
        request: AuthSignUpDataFlow.SignUp.Request,
        completion: @escaping ((AuthSignUpDataFlow.SignUpResult) -> Void)
    )
}

final class AuthSignUpProvider: AuthSignUpProviderProtocol {

    // MARK: - Properties
    private let service: AuthSignUpServiceProtocol
    
    // MARK: - Init
    init(service: AuthSignUpServiceProtocol =
                    AuthSignUpService(provider: AKNetworkProvider<AuthSignUpEndpoint>())) {
        self.service = service
    }
    
    // MARK: - AuthSignUpProviderProtocol

    func signup(
        request: AuthSignUpDataFlow.SignUp.Request,
        completion: @escaping ((AuthSignUpDataFlow.SignUpResult) -> Void)
    ) {
        service.signup(request: request) {
            switch $0 {
            case let .success(json):
                if let json = Auth(json: json) {
                    completion(.successful(model: json))
                } else {
                    completion(.failed(error: .invalidData))
                }
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }
}
