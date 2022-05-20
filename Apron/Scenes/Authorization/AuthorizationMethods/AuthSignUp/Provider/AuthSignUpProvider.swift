//
//  AuthSignUpProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol AuthSignUpProviderProtocol {
    
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

}
