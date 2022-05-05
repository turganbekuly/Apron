//
//  ShoppingListBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class ShoppingListBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: ShoppingListViewController.State
    
    // MARK: Initialization
    init(state: ShoppingListViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = ShoppingListPresenter()
        let interactor = ShoppingListInteractor(presenter: presenter)
        let viewController = ShoppingListViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
