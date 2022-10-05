//
//  RecipeSearchService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol RecipeSearchServiceProtocol {
    
}

final class RecipeSearchService: RecipeSearchServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<RecipeSearchEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<RecipeSearchEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - RecipeSearchServiceProtocol
    
}
