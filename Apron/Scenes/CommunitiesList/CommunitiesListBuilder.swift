//
//  CommunitiesListBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 19/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class CommunitiesListBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: CommunitiesListViewController.State
    
    // MARK: Initialization
    init(state: CommunitiesListViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = CommunitiesListPresenter()
        let interactor = CommunitiesListInteractor(presenter: presenter)
        let viewController = CommunitiesListViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
