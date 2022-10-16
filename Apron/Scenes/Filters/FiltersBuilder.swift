//
//  FiltersBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class FiltersBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: FiltersViewController.State
    
    // MARK: Initialization
    init(state: FiltersViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = FiltersPresenter()
        let interactor = FiltersInteractor(presenter: presenter)
        let viewController = FiltersViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
