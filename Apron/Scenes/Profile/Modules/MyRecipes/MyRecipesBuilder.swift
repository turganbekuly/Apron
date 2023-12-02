//
//  MyRecipesBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Protocols
import UIKit

final class MyRecipesBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: MyRecipesViewController.State
    
    // MARK: Initialization
    init(state: MyRecipesViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = MyRecipesPresenter()
        let interactor = MyRecipesInteractor(presenter: presenter)
        let viewController = MyRecipesViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
