//
//  CommunityCreationProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol CommunityCreationProviderProtocol {
    
}

final class CommunityCreationProvider: CommunityCreationProviderProtocol {

    // MARK: - Properties
    private let service: CommunityCreationServiceProtocol
    
    // MARK: - Init
    init(service: CommunityCreationServiceProtocol =
                    CommunityCreationService(provider: AKNetworkProvider<CommunityCreationEndpoint>())) {
        self.service = service
    }
    
    // MARK: - CommunityCreationProviderProtocol

}
