//
//  EditProfileBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Protocols
import UIKit

final class EditProfileBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: EditProfileViewController.State
    
    // MARK: Initialization
    init(state: EditProfileViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = EditProfilePresenter()
        let interactor = EditProfileInteractor(presenter: presenter)
        let viewController = EditProfileViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
