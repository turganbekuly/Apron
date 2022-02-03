//
//  CommunityPageProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

public protocol CommunityPageProviderProtocol {
    
}

public final class CommunityPageProvider: CommunityPageProviderProtocol {

    // MARK: - Properties
    private let service: CommunityPageServiceProtocol
    
    // MARK: - Init
    public init(service: CommunityPageServiceProtocol =
                    CommunityPageService(provider: AKNetworkProvider<CommunityPageEndpoint>())) {
        self.service = service
    }
    
    // MARK: - CommunityPageProviderProtocol

}
