//
//  GeneralSearchResultPagerBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class GeneralSearchResultPagerBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: GeneralSearchResultPagerViewController.State
    
    // MARK: Initialization
    init(state: GeneralSearchResultPagerViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let viewController = GeneralSearchResultPagerViewController(state: state)
        return viewController
    }
    
}
