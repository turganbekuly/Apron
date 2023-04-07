//
//  ViewControllerService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21.02.2023.
//

import AKNetwork
import Models

protocol ViewControllerServiceProtocol {
    func updateProfile(
        body: User,
        completion: @escaping (AKResult) -> Void
    )
}

final class ViewControllerService: ViewControllerServiceProtocol {
    // MARK: - Properties
    private let provider: AKNetworkProvider<ViewControllerEndpoints>

    // MARK: - Init
    init(provider: AKNetworkProvider<ViewControllerEndpoints>) {
        self.provider = provider
    }

    // MARK: - Methods

    func updateProfile(
        body: User,
        completion: @escaping (AKResult) -> Void
    ) {
        provider.send(target: .updateProfile(body: body)) { result in
            completion(result)
        }
    }
}
