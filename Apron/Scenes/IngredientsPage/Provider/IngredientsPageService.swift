//
//  IngredientsPageService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol IngredientsPageServiceProtocol {
    
}

final class IngredientsPageService: IngredientsPageServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<IngredientsPageEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<IngredientsPageEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - IngredientsPageServiceProtocol
    
}
