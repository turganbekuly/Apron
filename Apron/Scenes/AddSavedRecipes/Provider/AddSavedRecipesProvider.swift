//
//  AddSavedRecipesProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 26/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol AddSavedRecipesProviderProtocol {
    
}

final class AddSavedRecipesProvider: AddSavedRecipesProviderProtocol {

    // MARK: - Properties
    private let service: AddSavedRecipesServiceProtocol
    
    // MARK: - Init
    init(service: AddSavedRecipesServiceProtocol =
                    AddSavedRecipesService(provider: AKNetworkProvider<AddSavedRecipesEndpoint>())) {
        self.service = service
    }
    
    // MARK: - AddSavedRecipesProviderProtocol

}
