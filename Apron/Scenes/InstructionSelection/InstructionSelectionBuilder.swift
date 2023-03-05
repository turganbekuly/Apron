//
//  InstructionSelectionBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class InstructionSelectionBuilder: ModuleBuilderProtocol {

    // MARK: Properties
    private let state: InstructionSelectionViewController.State

    // MARK: Initialization
    init(state: InstructionSelectionViewController.State) {
        self.state = state
    }

    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = InstructionSelectionPresenter()
        let interactor = InstructionSelectionInteractor(presenter: presenter)
        let viewController = InstructionSelectionViewController(interactor: interactor, state: state)

        presenter.viewController = viewController

        return viewController
    }

}
