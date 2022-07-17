//
//  SplashScreenInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.06.2022.
//

import Foundation

protocol SplashScreenBusinessLogic {
    func updateToken(request: SplashScreenDataFlow.UpdateToken.Request)
}

final class SplashScreenInteractor: SplashScreenBusinessLogic {

    // MARK: - Properties

    private let presenter: SplashScreenPresentationLogic
    private let provider: SplashScreenProviderProtocol

    // MARK: - Init

    init(
        presenter: SplashScreenPresentationLogic,
        provider: SplashScreenProviderProtocol = SplashScreenProvider()
    ) {
        self.presenter = presenter
        self.provider = provider
    }

    // MARK: - SplashScreenBusinessLogic

    func updateToken(request: SplashScreenDataFlow.UpdateToken.Request) {
        provider.updateToken(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.updateToken(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.updateToken(response: .init(result: .failed(error: error)))
            }
        }
    }
}
