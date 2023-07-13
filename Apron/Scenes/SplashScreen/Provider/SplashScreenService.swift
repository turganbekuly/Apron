//
//  SplashScreenService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.06.2022.
//

protocol SplashScreenServiceProtocol {
    func updateToken(
        request: SplashScreenDataFlow.UpdateToken.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class SplashScreenService: SplashScreenServiceProtocol {
    // MARK: - Properties

    private let provider: AKNetworkProvider<SplashScreenEndpoints>

    // MARK: - Init

    init(provider: AKNetworkProvider<SplashScreenEndpoints>) {
        self.provider = provider
    }

    // MARK: - SplashScreenServiceProtocol

    func updateToken(
        request: SplashScreenDataFlow.UpdateToken.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .updateToken(refreshToken: request.token)) { result in
            completion(result)
        }
    }
}
