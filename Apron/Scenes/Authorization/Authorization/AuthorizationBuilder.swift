//
//  AuthorizationBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class AuthorizationBuilder: ModuleBuilderProtocol {

    // MARK: Properties
    private let state: AuthorizationViewController.State

    // MARK: Initialization
    init(state: AuthorizationViewController.State) {
        self.state = state
    }

    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = AuthorizationPresenter()
        let interactor = AuthorizationInteractor(presenter: presenter)
        let viewController = AuthorizationViewController(interactor: interactor, state: state)

        presenter.viewController = viewController

        return viewController
    }

}
