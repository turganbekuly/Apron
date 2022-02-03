//
//  CaloriesPageBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class CaloriesPageBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: CaloriesPageViewController.State
    
    // MARK: Initialization
    init(state: CaloriesPageViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = CaloriesPagePresenter()
        let interactor = CaloriesPageInteractor(presenter: presenter)
        let viewController = CaloriesPageViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
