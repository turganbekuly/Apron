//
//  RecipePageService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol RecipePageServiceProtocol {
    
}

final class RecipePageService: RecipePageServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<RecipePageEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<RecipePageEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - RecipePageServiceProtocol
    
}
