//
//  AuthSignUpService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol AuthSignUpServiceProtocol {
    
}

final class AuthSignUpService: AuthSignUpServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<AuthSignUpEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<AuthSignUpEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - AuthSignUpServiceProtocol
    
}
