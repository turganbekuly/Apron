//
//  AuthSignInBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class AuthSignInBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: AuthSignInViewController.State
    
    // MARK: Initialization
    init(state: AuthSignInViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = AuthSignInPresenter()
        let interactor = AuthSignInInteractor(presenter: presenter)
        let viewController = AuthSignInViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
