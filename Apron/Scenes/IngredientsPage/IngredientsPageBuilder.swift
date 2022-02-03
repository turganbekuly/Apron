//
//  IngredientsPageBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class IngredientsPageBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: IngredientsPageViewController.State
    
    // MARK: Initialization
    init(state: IngredientsPageViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = IngredientsPagePresenter()
        let interactor = IngredientsPageInteractor(presenter: presenter)
        let viewController = IngredientsPageViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
