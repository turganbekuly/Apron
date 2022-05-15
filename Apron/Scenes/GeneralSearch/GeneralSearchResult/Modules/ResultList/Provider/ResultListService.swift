//
//  ResultListService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol ResultListServiceProtocol {
    
}

final class ResultListService: ResultListServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<ResultListEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<ResultListEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - ResultListServiceProtocol
    
}
