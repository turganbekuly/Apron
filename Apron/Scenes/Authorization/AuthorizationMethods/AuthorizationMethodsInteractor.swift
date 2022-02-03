//
//  AuthorizationMethodsInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

public protocol AuthorizationMethodsBusinessLogic {
    
}

public final class AuthorizationMethodsInteractor: AuthorizationMethodsBusinessLogic {
    
    // MARK: - Properties
    private let presenter: AuthorizationMethodsPresentationLogic
    private let provider: AuthorizationMethodsProviderProtocol
    
    // MARK: - Initialization
    public init(presenter: AuthorizationMethodsPresentationLogic,
         provider: AuthorizationMethodsProviderProtocol = AuthorizationMethodsProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - AuthorizationMethodsBusinessLogic

}
