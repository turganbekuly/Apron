//
//  RecipeCreationProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/02/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol RecipeCreationProviderProtocol {
    
}

final class RecipeCreationProvider: RecipeCreationProviderProtocol {

    // MARK: - Properties
    private let service: RecipeCreationServiceProtocol
    
    // MARK: - Init
    init(service: RecipeCreationServiceProtocol =
                    RecipeCreationService(provider: AKNetworkProvider<RecipeCreationEndpoint>())) {
        self.service = service
    }
    
    // MARK: - RecipeCreationProviderProtocol

}
