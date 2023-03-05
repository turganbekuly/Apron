//
//  GeneralSearchBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class GeneralSearchBuilder: ModuleBuilderProtocol {

    // MARK: Properties
    private let state: GeneralSearchViewController.State

    // MARK: Initialization
    init(state: GeneralSearchViewController.State) {
        self.state = state
    }

    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = GeneralSearchPresenter()
        let interactor = GeneralSearchInteractor(presenter: presenter)
        let viewController = GeneralSearchViewController(interactor: interactor, state: state)

        presenter.viewController = viewController

        return viewController
    }

}
