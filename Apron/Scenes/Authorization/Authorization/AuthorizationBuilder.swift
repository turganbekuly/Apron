//
//  AuthorizationBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

public final class AuthorizationBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: AuthorizationViewController.State
    
    // MARK: Initialization
    public init(state: AuthorizationViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    public func build() -> ViewControllerProtocol {
        let viewController = AuthorizationViewController(state: state)
        
        return viewController
    }
    
}
