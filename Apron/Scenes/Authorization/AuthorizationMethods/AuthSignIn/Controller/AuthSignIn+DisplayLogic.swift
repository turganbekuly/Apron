//
//  AuthSignIn+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension AuthSignInViewController: AuthSignInDisplayLogic {
    
    // MARK: - AuthSignInDisplayLogic

    func login(viewModel: AuthSignInDataFlow.Login.ViewModel) {
        state = viewModel.state
    }
}
