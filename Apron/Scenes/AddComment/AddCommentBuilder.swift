//
//  AddCommentBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 30/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class AddCommentBuilder: ModuleBuilderProtocol {

    // MARK: Properties
    private let state: AddCommentViewController.State

    // MARK: Initialization
    init(state: AddCommentViewController.State) {
        self.state = state
    }

    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = AddCommentPresenter()
        let interactor = AddCommentInteractor(presenter: presenter)
        let viewController = AddCommentViewController(interactor: interactor, state: state)

        presenter.viewController = viewController

        return viewController
    }

}
