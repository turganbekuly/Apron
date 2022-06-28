//
//  ProfileService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol ProfileServiceProtocol {
    
}

final class ProfileService: ProfileServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<ProfileEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<ProfileEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - ProfileServiceProtocol
    
}
