//
//  IngredientSelectionProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol IngredientSelectionProviderProtocol {
    
}

final class IngredientSelectionProvider: IngredientSelectionProviderProtocol {

    // MARK: - Properties
    private let service: IngredientSelectionServiceProtocol
    
    // MARK: - Init
    init(service: IngredientSelectionServiceProtocol =
                    IngredientSelectionService(provider: AKNetworkProvider<IngredientSelectionEndpoint>())) {
        self.service = service
    }
    
    // MARK: - IngredientSelectionProviderProtocol

}
