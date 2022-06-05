//
//  SplashScreen+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.06.2022.
//

import Foundation

extension SplashScreenViewController: SplashScreenDisplayLogic {
    // MARK: - SplashScreenDisplayLogic

    func displayUpdateToken(with viewModel: SplashScreenDataFlow.UpdateToken.ViewModel) {
        state = viewModel.state
    }
}
