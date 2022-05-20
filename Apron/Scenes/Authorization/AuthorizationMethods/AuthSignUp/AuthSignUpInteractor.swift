//
//  AuthSignUpInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol AuthSignUpBusinessLogic {
    
}

final class AuthSignUpInteractor: AuthSignUpBusinessLogic {
    
    // MARK: - Properties
    private let presenter: AuthSignUpPresentationLogic
    private let provider: AuthSignUpProviderProtocol
    
    // MARK: - Initialization
    init(presenter: AuthSignUpPresentationLogic,
         provider: AuthSignUpProviderProtocol = AuthSignUpProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - AuthSignUpBusinessLogic

}
