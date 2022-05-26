//
//  AddSavedRecipesBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 26/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class AddSavedRecipesBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: AddSavedRecipesViewController.State
    
    // MARK: Initialization
    init(state: AddSavedRecipesViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = AddSavedRecipesPresenter()
        let interactor = AddSavedRecipesInteractor(presenter: presenter)
        let viewController = AddSavedRecipesViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
