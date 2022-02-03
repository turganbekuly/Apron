//
//  SearchService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 14/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

public protocol SearchServiceProtocol {
    
}

public final class SearchService: SearchServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<SearchEndpoint>

    // MARK: - Init
    public init(provider: AKNetworkProvider<SearchEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - SearchServiceProtocol
    
}
