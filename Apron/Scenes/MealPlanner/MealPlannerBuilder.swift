//
//  MealPlannerBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/01/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Protocols
import UIKit

final class MealPlannerBuilder: ModuleBuilderProtocol {

    // MARK: Properties
    private let state: MealPlannerViewController.State

    // MARK: Initialization
    init(state: MealPlannerViewController.State) {
        self.state = state
    }

    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = MealPlannerPresenter()
        let interactor = MealPlannerInteractor(presenter: presenter)
        let viewController = MealPlannerViewController(interactor: interactor, state: state)

        presenter.viewController = viewController

        return viewController
    }

}
