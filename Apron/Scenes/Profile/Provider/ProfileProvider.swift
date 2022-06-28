//
//  ProfileProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol ProfileProviderProtocol {
    
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

}
