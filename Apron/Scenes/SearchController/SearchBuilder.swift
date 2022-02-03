//
//  SearchBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 14/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

public final class SearchBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: SearchViewController.State
    
    // MARK: Initialization
    public init(state: SearchViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    public func build() -> ViewControllerProtocol {
        let presenter = SearchPresenter()
        let interactor = SearchInteractor(presenter: presenter)
        let viewController = SearchViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
