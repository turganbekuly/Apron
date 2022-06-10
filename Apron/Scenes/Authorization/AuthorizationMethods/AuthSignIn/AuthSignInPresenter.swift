//
//  AuthSignInPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol AuthSignInPresentationLogic: AnyObject {
    func login(response: AuthSignInDataFlow.Login.Response)
}

final class AuthSignInPresenter: AuthSignInPresentationLogic {
    
    // MARK: - Properties
    weak var viewController: AuthSignInDisplayLogic?
    
    // MARK: - AuthSignInPresentationLogic

    func login(response: AuthSignInDataFlow.Login.Response) {
        DispatchQueue.main.async {
            var viewModel: AuthSignInDataFlow.Login.ViewModel

            defer { self.viewController?.login(viewModel: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .loginSucceed(model))
            case let .failed(error):
                viewModel = .init(state: .loginFailed(error))
            }
        }
    }
}
