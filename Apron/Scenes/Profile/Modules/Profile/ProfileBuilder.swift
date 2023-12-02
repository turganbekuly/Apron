//
//  ProfileBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class ProfileBuilder: ModuleBuilderProtocol {

    // MARK: Properties
    private let state: ProfileViewController.State

    // MARK: Initialization
    init(state: ProfileViewController.State) {
        self.state = state
    }

    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor(presenter: presenter)
        let viewController = ProfileViewController(interactor: interactor, state: state)

        presenter.viewController = viewController

        return viewController
    }

}
