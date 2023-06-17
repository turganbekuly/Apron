//
//  ViewControllerProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20.02.2023.
//


import Models

enum ViewControllerProfileResult {
    case success(UserUpdateResponse)
    case failed(AKNetworkError)
}

protocol ViewControllerProviderProtocol {
    func updateProfile(
        body: User,
        completion: @escaping (ViewControllerProfileResult) -> Void
    )
}

final class ViewControllerProvider: ViewControllerProviderProtocol {

    // MARK: - Properties
    private let service: ViewControllerServiceProtocol

    // MARK: - Init
    init(
        service: ViewControllerServiceProtocol = ViewControllerService(provider: AKNetworkProvider<ViewControllerEndpoints>())
    ) {
        self.service = service
    }

    // MARK: - Methods

    func updateProfile(
        body: User,
        completion: @escaping (ViewControllerProfileResult) -> Void
    ) {
        service.updateProfile(body: body) {
            switch $0 {
            case let .success(json):
                if let jsons = UserUpdateResponse(json: json) {
                    completion(.success(jsons))
                } else {
                    completion(.failed(.invalidData))
                }
            case let .failure(error):
                completion(.failed(error))
            }
        }
    }
}
