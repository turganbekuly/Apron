//
//  Authorization+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.05.2022.
//

import Foundation

extension AuthorizationViewController: AuthorizationDisplayLogic {
    func login(viewModel: AuthorizationDataFlow.Login.ViewModel) {
        state = viewModel.state
    }
}
