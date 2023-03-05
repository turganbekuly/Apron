//
//  SplashScreenPresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.06.2022.
//

import UIKit

protocol SplashScreenPresentationLogic: AnyObject {
    func updateToken(response: SplashScreenDataFlow.UpdateToken.Response)
}

final class SplashScreenPresenter: SplashScreenPresentationLogic {
    // MARK: - Properties

    weak var viewController: SplashScreenDisplayLogic?

    // MARK: - SplashScreenPresentationLogic

    func updateToken(response: SplashScreenDataFlow.UpdateToken.Response) {
        DispatchQueue.main.async {
            var viewModel: SplashScreenDataFlow.UpdateToken.ViewModel

            defer { self.viewController?.displayUpdateToken(with: viewModel) }

            switch response.result {
            case let .successful(model):
                viewModel = .init(state: .updateTokenSucceed(model))
            case let .failed(error):
                viewModel = .init(state: .updateTokenFailed(error))
            }
        }
    }
}
