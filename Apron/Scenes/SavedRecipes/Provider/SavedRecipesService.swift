//
//  SavedRecipesService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 10/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol SavedRecipesServiceProtocol {
    
}

final class SavedRecipesService: SavedRecipesServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<SavedRecipesEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<SavedRecipesEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - SavedRecipesServiceProtocol
    
}
