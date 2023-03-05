//
//  ProfileProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork
import Models

protocol ProfileProviderProtocol {
    func getProfile(
        request: ProfileDataFlow.GetProfile.Request,
        completion: @escaping ((ProfileDataFlow.GetProfileResult) -> Void)
    )
    func deleteAccount(
        request: ProfileDataFlow.DeleteAccount.Request,
        completion: @escaping ((ProfileDataFlow.DeleteAccountResult) -> Void)
    )
}

final class ProfileProvider: ProfileProviderProtocol {

    // MARK: - Properties
    private let service: ProfileServiceProtocol

    // MARK: - Init
    init(service: ProfileServiceProtocol =
                    ProfileService(provider: AKNetworkProvider<ProfileEndpoint>())) {
        self.service = service
    }

    // MARK: - ProfileProviderProtocol

    func getProfile(
        request: ProfileDataFlow.GetProfile.Request,
        completion: @escaping ((ProfileDataFlow.GetProfileResult) -> Void)
    ) {
        service.getProfile(request: request) {
            switch $0 {
            case let .success(json):
                if let json = User(json: json) {
                    completion(.successful(json))
                } else {
                    completion(.failed(.invalidData))
                }
            case let .failure(error):
                completion(.failed(error))
            }
        }
    }

    func deleteAccount(
        request: ProfileDataFlow.DeleteAccount.Request,
        completion: @escaping ((ProfileDataFlow.DeleteAccountResult) -> Void)
    ) {
        service.deleteAccount(request: request) {
            switch $0 {
            case .success:
                completion(.successful)
            case let .failure(error):
                completion(.failed(error))
            }
        }
    }

}
