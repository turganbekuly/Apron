//
//  StepByStepModeBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24/08/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class StepByStepModeBuilder: ModuleBuilderProtocol {

    // MARK: Properties
    private let state: StepByStepModeViewController.State

    // MARK: Initialization
    init(state: StepByStepModeViewController.State) {
        self.state = state
    }

    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = StepByStepModePresenter()
        let interactor = StepByStepModeInteractor(presenter: presenter)
        let viewController = StepByStepModeViewController(interactor: interactor, state: state)

        presenter.viewController = viewController

        return viewController
    }

}
