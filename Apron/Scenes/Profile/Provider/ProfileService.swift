//
//  ProfileService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol ProfileServiceProtocol {
    func getProfile(
        request: ProfileDataFlow.GetProfile.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    func deleteAccount(
        request: ProfileDataFlow.DeleteAccount.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class ProfileService: ProfileServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<ProfileEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<ProfileEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - ProfileServiceProtocol

    func getProfile(
        request: ProfileDataFlow.GetProfile.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .getProfile) { result in
            completion(result)
        }
    }

    func deleteAccount(
        request: ProfileDataFlow.DeleteAccount.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .deleteprofile(request.id)) { result in
            completion(result)
        }
    }
}
