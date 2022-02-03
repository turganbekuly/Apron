//
//  IngredientsPageProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol IngredientsPageProviderProtocol {
    
}

final class IngredientsPageProvider: IngredientsPageProviderProtocol {

    // MARK: - Properties
    private let service: IngredientsPageServiceProtocol
    
    // MARK: - Init
    init(service: IngredientsPageServiceProtocol =
                    IngredientsPageService(provider: AKNetworkProvider<IngredientsPageEndpoint>())) {
        self.service = service
    }
    
    // MARK: - IngredientsPageProviderProtocol

}
