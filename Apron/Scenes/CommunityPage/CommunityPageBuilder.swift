//
//  CommunityPageBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class CommunityPageBuilder: ModuleBuilderProtocol {

    // MARK: Properties
    private let state: CommunityPageViewController.State

    // MARK: Initialization
    init(state: CommunityPageViewController.State) {
        self.state = state
    }

    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = CommunityPagePresenter()
        let interactor = CommunityPageInteractor(presenter: presenter)
        let viewController = CommunityPageViewController(interactor: interactor, state: state)

        presenter.viewController = viewController

        return viewController
    }

}
