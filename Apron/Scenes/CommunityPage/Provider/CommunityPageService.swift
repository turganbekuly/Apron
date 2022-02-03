//
//  CommunityPageService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 17/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

public protocol CommunityPageServiceProtocol {
    
}

public final class CommunityPageService: CommunityPageServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<CommunityPageEndpoint>

    // MARK: - Init
    public init(provider: AKNetworkProvider<CommunityPageEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - CommunityPageServiceProtocol
    
}
