//
//  IngredientInsertionProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol IngredientInsertionProviderProtocol {
    
}

final class IngredientInsertionProvider: IngredientInsertionProviderProtocol {

    // MARK: - Properties
    private let service: IngredientInsertionServiceProtocol
    
    // MARK: - Init
    init(service: IngredientInsertionServiceProtocol =
                    IngredientInsertionService(provider: AKNetworkProvider<IngredientInsertionEndpoint>())) {
        self.service = service
    }
    
    // MARK: - IngredientInsertionProviderProtocol

}
