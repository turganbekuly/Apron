//
//  SavedRecipesProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol SavedRecipesProviderProtocol {
    
}

final class SavedRecipesProvider: SavedRecipesProviderProtocol {

    // MARK: - Properties
    private let service: SavedRecipesServiceProtocol
    
    // MARK: - Init
    init(service: SavedRecipesServiceProtocol =
                    SavedRecipesService(provider: AKNetworkProvider<SavedRecipesEndpoint>())) {
        self.service = service
    }
    
    // MARK: - SavedRecipesProviderProtocol

}
