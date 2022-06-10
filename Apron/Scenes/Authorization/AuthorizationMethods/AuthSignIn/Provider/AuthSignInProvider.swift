//
//  AuthSignInProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork
import Models

protocol AuthSignInProviderProtocol {
    func login(
        request: AuthSignInDataFlow.Login.Request,
        compeletion: @escaping ((AuthSignInDataFlow.LoginResult) -> Void)
    )
}

final class AuthSignInProvider: AuthSignInProviderProtocol {

    // MARK: - Properties
    private let service: AuthSignInServiceProtocol
    
    // MARK: - Init
    init(service: AuthSignInServiceProtocol =
                    AuthSignInService(provider: AKNetworkProvider<AuthSignInEndpoint>())) {
        self.service = service
    }
    
    // MARK: - AuthSignInProviderProtocol

    func login(
        request: AuthSignInDataFlow.Login.Request,
        compeletion: @escaping ((AuthSignInDataFlow.LoginResult) -> Void)
    ) {
        service.login(request: request) {
            switch $0 {
            case let .success(json):
                if let jsons = Auth(json: json) {
                    compeletion(.successful(model: jsons))
                } else {
                    compeletion(.failed(error: .invalidData))
                }
            case let .failure(error):
                compeletion(.failed(error: error))
            }
        }
    }
}
