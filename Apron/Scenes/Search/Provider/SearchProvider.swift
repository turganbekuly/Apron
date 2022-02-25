//
//  SearchProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol SearchProviderProtocol {
    
}

final class SearchProvider: SearchProviderProtocol {

    // MARK: - Properties
    private let service: SearchServiceProtocol
    
    // MARK: - Init
    init(service: SearchServiceProtocol =
                    SearchService(provider: AKNetworkProvider<SearchEndpoint>())) {
        self.service = service
    }
    
    // MARK: - SearchProviderProtocol

}
