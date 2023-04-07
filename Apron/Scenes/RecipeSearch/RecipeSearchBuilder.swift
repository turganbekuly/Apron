//
//  RecipeSearchBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class RecipeSearchBuilder: ModuleBuilderProtocol {

    // MARK: Properties
    private let state: RecipeSearchViewController.State

    // MARK: Initialization
    init(state: RecipeSearchViewController.State) {
        self.state = state
    }

    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = RecipeSearchPresenter()
        let interactor = RecipeSearchInteractor(presenter: presenter)
        let viewController = RecipeSearchViewController(interactor: interactor, state: state)

        presenter.viewController = viewController

        return viewController
    }

}
