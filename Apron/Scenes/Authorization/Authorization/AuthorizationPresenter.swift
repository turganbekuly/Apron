//
//  AuthorizationPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.05.2022.
//

import UIKit

protocol AuthorizationPresentationLogic: AnyObject {
    func login(response: AuthorizationDataFlow.AuthorizationWithApple.Response)
}

final class AuthorizationPresenter: AuthorizationPresentationLogic {

    // MARK: - Properties
    weak var viewController: AuthorizationDisplayLogic?

    // MARK: - RecipeCreationPresentationLogic

    func login(response: AuthorizationDataFlow.AuthorizationWithApple.Response) {
        DispatchQueue.main.async {
            var viewModel: AuthorizationDataFlow.AuthorizationWithApple.ViewModel

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
