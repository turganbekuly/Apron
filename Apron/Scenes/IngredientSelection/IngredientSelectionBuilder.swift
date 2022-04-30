//
//  IngredientSelectionBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class IngredientSelectionBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: IngredientSelectionViewController.State
    
    // MARK: Initialization
    init(state: IngredientSelectionViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = IngredientSelectionPresenter()
        let interactor = IngredientSelectionInteractor(presenter: presenter)
        let viewController = IngredientSelectionViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
