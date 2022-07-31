//
//  SplashScreenProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.06.2022.
//

import AKNetwork
import Models

protocol SplashScreenProviderProtocol {
    func updateToken(
        request: SplashScreenDataFlow.UpdateToken.Request,
        completion: @escaping ((SplashScreenDataFlow.UpdateTokenResult) -> Void)
    )
}

final class SplashScreenProvider: SplashScreenProviderProtocol {
    // MARK: - Properties

    private let service: SplashScreenServiceProtocol

    // MARK: - Init

    init(service: SplashScreenServiceProtocol =
         SplashScreenService(provider: AKNetworkProvider<SplashScreenEndpoints>())) {
        self.service = service
    }

    // MARK: - SplashScreenProviderProtocol

    func updateToken(
        request: SplashScreenDataFlow.UpdateToken.Request,
        completion: @escaping ((SplashScreenDataFlow.UpdateTokenResult) -> Void)
    ) {
        service.updateToken(request: request) {
            switch $0 {
            case let .success(json):
                if let jsons = json["access_token"] as? String {
                    completion(.successful(accessToken: jsons))
                } else {
                    completion(.failed(error: .invalidData))
                }
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }
}
