//
//  IngredientInsertionBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class IngredientInsertionBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: IngredientInsertionViewController.State
    
    // MARK: Initialization
    init(state: IngredientInsertionViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = IngredientInsertionPresenter()
        let interactor = IngredientInsertionInteractor(presenter: presenter)
        let viewController = IngredientInsertionViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
