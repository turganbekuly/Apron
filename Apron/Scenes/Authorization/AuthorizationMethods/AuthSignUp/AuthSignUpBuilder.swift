//
//  AuthSignUpBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class AuthSignUpBuilder: ModuleBuilderProtocol {

    // MARK: Properties
    private let state: AuthSignUpViewController.State

    // MARK: Initialization
    init(state: AuthSignUpViewController.State) {
        self.state = state
    }

    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = AuthSignUpPresenter()
        let interactor = AuthSignUpInteractor(presenter: presenter)
        let viewController = AuthSignUpViewController(interactor: interactor, state: state)

        presenter.viewController = viewController

        return viewController
    }

}
