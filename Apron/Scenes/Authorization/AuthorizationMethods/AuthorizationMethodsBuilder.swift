//
//  AuthorizationMethodsBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

public final class AuthorizationMethodsBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: AuthorizationMethodsViewController.State
    
    // MARK: Initialization
    public init(state: AuthorizationMethodsViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    public func build() -> ViewControllerProtocol {
        let presenter = AuthorizationMethodsPresenter()
        let interactor = AuthorizationMethodsInteractor(presenter: presenter)
        let viewController = AuthorizationMethodsViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
