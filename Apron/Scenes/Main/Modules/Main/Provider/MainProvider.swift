//
//  MainProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import AKNetwork
import Models

protocol MainProviderProtocol {
    func joinCommunity(
        request: MainDataFlow.JoinCommunity.Request,
        completion: @escaping (MainDataFlow.JoinCommunityResult) -> Void
    )
}

final class MainProvider: MainProviderProtocol {

    // MARK: - Properties
    private let service: MainServiceProtocol

    // MARK: - Init
    init(service: MainServiceProtocol =
         MainService(provider: AKNetworkProvider<MainEndpoint>())) {
        self.service = service
    }

    // MARK: - RecipePageProviderProtocol

    func joinCommunity(
        request: MainDataFlow.JoinCommunity.Request,
        completion: @escaping (MainDataFlow.JoinCommunityResult) -> Void
    ) {
        service.joinCommunity(request: request) {
            switch $0 {
            case .success(_):
                completion(.successfull)
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }
}
