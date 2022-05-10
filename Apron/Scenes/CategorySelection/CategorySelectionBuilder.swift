//
//  CategorySelectionBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class CategorySelectionBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: CategorySelectionViewController.State
    
    // MARK: Initialization
    init(state: CategorySelectionViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = CategorySelectionPresenter()
        let interactor = CategorySelectionInteractor(presenter: presenter)
        let viewController = CategorySelectionViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
