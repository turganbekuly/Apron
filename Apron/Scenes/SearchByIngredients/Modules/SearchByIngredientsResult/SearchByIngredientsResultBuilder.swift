//
//  SearchByIngredientsResultBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25/08/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Protocols
import UIKit

final class SearchByIngredientsResultBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: SearchByIngredientsResultViewController.State
    
    // MARK: Initialization
    init(state: SearchByIngredientsResultViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = SearchByIngredientsResultPresenter()
        let interactor = SearchByIngredientsResultInteractor(presenter: presenter)
        let viewController = SearchByIngredientsResultViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
