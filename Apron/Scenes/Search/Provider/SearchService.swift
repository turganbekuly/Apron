//
//  SearchService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol SearchServiceProtocol {

}

final class SearchService: SearchServiceProtocol {

    // MARK: - Properties
    private let provider: AKNetworkProvider<SearchEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<SearchEndpoint>) {
        self.provider = provider
    }

    // MARK: - SearchServiceProtocol

}
