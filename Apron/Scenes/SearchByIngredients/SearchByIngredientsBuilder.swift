//
//  SearchByIngredientsBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Protocols
import UIKit

final class SearchByIngredientsBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: SearchByIngredientsViewController.State
    
    // MARK: Initialization
    init(state: SearchByIngredientsViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = SearchByIngredientsPresenter()
        let interactor = SearchByIngredientsInteractor(presenter: presenter)
        let viewController = SearchByIngredientsViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
