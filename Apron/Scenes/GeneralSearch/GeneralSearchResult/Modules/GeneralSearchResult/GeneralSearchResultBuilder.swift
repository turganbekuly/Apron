//
//  GeneralSearchResultBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class GeneralSearchResultBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: GeneralSearchResultViewController.State
    
    // MARK: Initialization
    init(state: GeneralSearchResultViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = GeneralSearchResultPresenter()
        let interactor = GeneralSearchResultInteractor(presenter: presenter)
        let viewController = GeneralSearchResultViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
