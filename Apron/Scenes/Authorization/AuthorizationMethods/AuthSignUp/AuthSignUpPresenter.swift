//
//  AuthSignUpPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

protocol AuthSignUpPresentationLogic: AnyObject {
    func signup(response: AuthSignUpDataFlow.SignUp.Response)
}

final class AuthSignUpPresenter: AuthSignUpPresentationLogic {

    // MARK: - Properties
    weak var viewController: AuthSignUpDisplayLogic?

    // MARK: - AuthSignUpPresentationLogic

    func signup(response: AuthSignUpDataFlow.SignUp.Response) {
        DispatchQueue.main.async {
            var viewModel: AuthSignUpDataFlow.SignUp.ViewModel

            defer { self.viewController?.displaySignUp(with: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .signupSucceed(model))
            case let .failed(error):
                viewModel = .init(state: .signupFailed(error))
            }
        }
    }
}
