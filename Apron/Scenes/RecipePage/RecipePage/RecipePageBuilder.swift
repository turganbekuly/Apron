//
//  RecipePageBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class RecipePageBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: RecipePageViewController.State
    
    // MARK: Initialization
    init(state: RecipePageViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = RecipePagePresenter()
        let interactor = RecipePageInteractor(presenter: presenter)
        let viewController = RecipePageViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
