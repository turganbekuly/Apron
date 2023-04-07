//
//  PreShoppingListBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class PreShoppingListBuilder: ModuleBuilderProtocol {

    // MARK: Properties
    private let state: PreShoppingListViewController.State

    // MARK: Initialization
    init(state: PreShoppingListViewController.State) {
        self.state = state
    }

    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let viewController = PreShoppingListViewController(state: state)
        return viewController
    }

}
