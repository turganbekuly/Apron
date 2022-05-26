//
//  AddSavedRecipesService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 26/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol AddSavedRecipesServiceProtocol {
    
}

final class AddSavedRecipesService: AddSavedRecipesServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<AddSavedRecipesEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<AddSavedRecipesEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - AddSavedRecipesServiceProtocol
    
}
