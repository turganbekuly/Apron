//
//  AuthSignInService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol AuthSignInServiceProtocol {
    
}

final class AuthSignInService: AuthSignInServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<AuthSignInEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<AuthSignInEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - AuthSignInServiceProtocol
    
}
