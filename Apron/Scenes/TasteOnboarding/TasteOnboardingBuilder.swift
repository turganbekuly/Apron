//
//  TasteOnboardingBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

public final class TasteOnboardingBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: TasteOnboardingViewController.State
    
    // MARK: Initialization
    public init(state: TasteOnboardingViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    public func build() -> ViewControllerProtocol {
        let presenter = TasteOnboardingPresenter()
        let interactor = TasteOnboardingInteractor(presenter: presenter)
        let viewController = TasteOnboardingViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
