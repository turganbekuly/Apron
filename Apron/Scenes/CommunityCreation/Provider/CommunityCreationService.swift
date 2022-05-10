//
//  CommunityCreationService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol CommunityCreationServiceProtocol {
    
}

final class CommunityCreationService: CommunityCreationServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<CommunityCreationEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<CommunityCreationEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - CommunityCreationServiceProtocol
    
}
