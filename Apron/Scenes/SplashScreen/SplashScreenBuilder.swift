//
//  SplashScreenBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

public final class SplashScreenBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: SplashScreenViewController.State
    
    // MARK: Initialization
    public init(state: SplashScreenViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    public func build() -> ViewControllerProtocol {
        let viewController = SplashScreenViewController(state: state)
        
        return viewController
    }
    
}
