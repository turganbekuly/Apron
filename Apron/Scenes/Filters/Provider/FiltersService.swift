//
//  FiltersService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol FiltersServiceProtocol {
    
}

final class FiltersService: FiltersServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<FiltersEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<FiltersEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - FiltersServiceProtocol
    
}
