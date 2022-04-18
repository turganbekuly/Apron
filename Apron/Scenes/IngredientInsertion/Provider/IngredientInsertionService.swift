//
//  IngredientInsertionService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol IngredientInsertionServiceProtocol {
    
}

final class IngredientInsertionService: IngredientInsertionServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<IngredientInsertionEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<IngredientInsertionEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - IngredientInsertionServiceProtocol
    
}
