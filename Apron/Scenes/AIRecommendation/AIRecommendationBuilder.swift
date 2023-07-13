//
//  AIRecommendationBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 27/05/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Protocols
import UIKit

final class AIRecommendationBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: AIRecommendationViewController.State
    
    // MARK: Initialization
    init(state: AIRecommendationViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = AIRecommendationPresenter()
        let interactor = AIRecommendationInteractor(presenter: presenter)
        let viewController = AIRecommendationViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
