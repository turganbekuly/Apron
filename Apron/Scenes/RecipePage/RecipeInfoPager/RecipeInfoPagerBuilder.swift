//
//  RecipeInfoPagerBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27.01.2022.
//

import Protocols
import UIKit

final class RecipeInfoPagerBuilder: ModuleBuilderProtocol {

    // MARK: Properties

    private var state: RecipeInfoPagerViewController.State

    // MARK: Initialization

    init(state: RecipeInfoPagerViewController.State) {
        self.state = state
    }

    // MARK: - ModuleBuilder

    func build() -> ViewControllerProtocol {
        let viewController = RecipeInfoPagerViewController(state: state)
        return viewController
    }

}

