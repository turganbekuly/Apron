//
//  RecipeCreationBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class RecipeCreationBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: RecipeCreationViewController.State
    
    // MARK: Initialization
    init(state: RecipeCreationViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = RecipeCreationPresenter()
        let interactor = RecipeCreationInteractor(presenter: presenter)
        let viewController = RecipeCreationViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
