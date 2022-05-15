//
//  ResultListBuilder.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Protocols
import UIKit

final class ResultListBuilder: ModuleBuilderProtocol {
    
    // MARK: Properties
    private let state: ResultListViewController.State
    
    // MARK: Initialization
    init(state: ResultListViewController.State) {
        self.state = state
    }
    
    // MARK: - ModuleBuilder
    func build() -> ViewControllerProtocol {
        let presenter = ResultListPresenter()
        let interactor = ResultListInteractor(presenter: presenter)
        let viewController = ResultListViewController(interactor: interactor, state: state)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
