//
//  AssignBottomSheetBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit
import PanModal

final class AssignBottomSheetBuilder {
    
    // MARK: Properties
    private let state: AssignBottomSheetViewController.State
    
    // MARK: Initialization
    init(state: AssignBottomSheetViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> UIViewController & PanModalPresentable {
        let viewController = AssignBottomSheetViewController(state: state)
        return viewController
    }
    
}
