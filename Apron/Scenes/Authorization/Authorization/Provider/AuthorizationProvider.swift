//
//  AuthorizationProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork
import Models

protocol AuthorizationProviderProtocol {
    func login(
        request: AuthorizationDataFlow.Login.Request,
        compeletion: @escaping ((AuthorizationDataFlow.LoginResult) -> Void)
    )
}

final class AuthorizationProvider: AuthorizationProviderProtocol {

    // MARK: - Properties
    private let service: AuthorizationServiceProtocol

    // MARK: - Init
    init(service: AuthorizationServiceProtocol =
            AuthorizationService(provider: AKNetworkProvider<AuthorizationEndpoints>())) {
        self.service = service
    }

    // MARK: - RecipeCreationProviderProtocol

    func login(
        request: AuthorizationDataFlow.Login.Request,
        compeletion: @escaping ((AuthorizationDataFlow.LoginResult) -> Void)
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
