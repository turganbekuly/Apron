//
//  InstructionsPageBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class InstructionsPageBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: InstructionsPageViewController.State
    
    // MARK: Initialization
    init(state: InstructionsPageViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = InstructionsPagePresenter()
        let interactor = InstructionsPageInteractor(presenter: presenter)
        let viewController = InstructionsPageViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
