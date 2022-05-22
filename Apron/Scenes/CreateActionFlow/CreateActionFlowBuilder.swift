//
//  CreateActionFlowBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit
import PanModal

final class CreateActionFlowBuilder {
    
    // MARK: Properties
    private let state: CreateActionFlowViewController.State
    
    // MARK: Initialization
    init(state: CreateActionFlowViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> UIViewController & PanModalPresentable {
        let viewController = CreateActionFlowViewController(state: state)

        return viewController
    }
    
}
