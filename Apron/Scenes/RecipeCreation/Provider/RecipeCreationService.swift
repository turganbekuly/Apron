//
//  RecipeCreationService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol RecipeCreationServiceProtocol {
    
}

final class RecipeCreationService: RecipeCreationServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<RecipeCreationEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<RecipeCreationEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - RecipeCreationServiceProtocol
    
}
