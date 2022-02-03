//
//  MainBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 07/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

public final class MainBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: MainViewController.State
    
    // MARK: Initialization
    public init(state: MainViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    public func build() -> ViewControllerProtocol {
        let presenter = MainPresenter()
        let interactor = MainInteractor(presenter: presenter)
        let viewController = MainViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
