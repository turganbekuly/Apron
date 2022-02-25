//
//  CommunityCreationBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class CommunityCreationBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: CommunityCreationViewController.State
    
    // MARK: Initialization
    init(state: CommunityCreationViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = CommunityCreationPresenter()
        let interactor = CommunityCreationInteractor(presenter: presenter)
        let viewController = CommunityCreationViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
