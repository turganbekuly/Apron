//
//  AuthSignInInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol AuthSignInBusinessLogic {
    
}

final class AuthSignInInteractor: AuthSignInBusinessLogic {
    
    // MARK: - Properties
    private let presenter: AuthSignInPresentationLogic
    private let provider: AuthSignInProviderProtocol
    
    // MARK: - Initialization
    init(presenter: AuthSignInPresentationLogic,
         provider: AuthSignInProviderProtocol = AuthSignInProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - AuthSignInBusinessLogic

}
