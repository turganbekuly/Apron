//
//  MarketplaceBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Protocols
import UIKit

final class MarketplaceBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: MarketplaceViewController.State
    
    // MARK: Initialization
    init(state: MarketplaceViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = MarketplacePresenter()
        let interactor = MarketplaceInteractor(presenter: presenter)
        let viewController = MarketplaceViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
