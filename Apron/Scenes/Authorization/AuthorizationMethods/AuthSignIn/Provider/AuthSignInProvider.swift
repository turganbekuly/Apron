//
//  AuthSignInProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol AuthSignInProviderProtocol {
    
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

}
