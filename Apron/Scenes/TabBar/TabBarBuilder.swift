//
//  TabBarBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class TabBarBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: TabBarViewController.State
    
    // MARK: Initialization
    init(state: TabBarViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let viewController = TabBarViewController(state: state)
        return viewController
    }
    
}
