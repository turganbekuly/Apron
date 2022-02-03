//
//  RecipePageProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol RecipePageProviderProtocol {
    
}

final class RecipePageProvider: RecipePageProviderProtocol {

    // MARK: - Properties
    private let service: RecipePageServiceProtocol
    
    // MARK: - Init
    init(service: RecipePageServiceProtocol =
                    RecipePageService(provider: AKNetworkProvider<RecipePageEndpoint>())) {
        self.service = service
    }
    
    // MARK: - RecipePageProviderProtocol

}
