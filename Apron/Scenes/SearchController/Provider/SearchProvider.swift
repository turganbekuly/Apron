//
//  SearchProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 14/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

public protocol SearchProviderProtocol {
    
}

public final class SearchProvider: SearchProviderProtocol {

    // MARK: - Properties
    private let service: SearchServiceProtocol
    
    // MARK: - Init
    public init(service: SearchServiceProtocol =
                    SearchService(provider: AKNetworkProvider<SearchEndpoint>())) {
        self.service = service
    }
    
    // MARK: - SearchProviderProtocol

}
