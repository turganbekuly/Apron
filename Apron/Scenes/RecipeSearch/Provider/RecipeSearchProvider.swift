//
//  RecipeSearchProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol RecipeSearchProviderProtocol {
    
}

final class RecipeSearchProvider: RecipeSearchProviderProtocol {

    // MARK: - Properties
    private let service: RecipeSearchServiceProtocol
    
    // MARK: - Init
    init(service: RecipeSearchServiceProtocol =
                    RecipeSearchService(provider: AKNetworkProvider<RecipeSearchEndpoint>())) {
        self.service = service
    }
    
    // MARK: - RecipeSearchProviderProtocol

}
