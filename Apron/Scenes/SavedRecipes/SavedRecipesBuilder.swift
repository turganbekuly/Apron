//
//  SavedRecipesBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class SavedRecipesBuilder: ModuleBuilderProtocol {

    // MARK: Properties
    private let state: SavedRecipesViewController.State

    // MARK: Initialization
    init(state: SavedRecipesViewController.State) {
        self.state = state
    }

    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = SavedRecipesPresenter()
        let interactor = SavedRecipesInteractor(presenter: presenter)
        let viewController = SavedRecipesViewController(interactor: interactor, state: state)

        presenter.viewController = viewController

        return viewController
    }

}
