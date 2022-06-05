//
//  SplashScreenBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class SplashScreenBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: SplashScreenViewController.State
    
    // MARK: Initialization
    init(state: SplashScreenViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = SplashScreenPresenter()
        let interactor = SplashScreenInteractor(presenter: presenter)
        let viewController = SplashScreenViewController(interactor: interactor, state: state)

        presenter.viewController = viewController
        return viewController
    }
    
}
