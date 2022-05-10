//
//  MainService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10.05.2022.
//

import AKNetwork
import Models

protocol MainServiceProtocol {
    func joinCommunity(
        request: MainDataFlow.JoinCommunity.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class MainService: MainServiceProtocol {

    // MARK: - Properties
    private let provider: AKNetworkProvider<MainEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<MainEndpoint>) {
        self.provider = provider
    }

    // MARK: - RecipePageServiceProtocol

    func joinCommunity(
        request: MainDataFlow.JoinCommunity.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .joinCommunity(id: request.id)) { result in
            completion(result)
        }
    }
}
