//
//  GeneralSearchResultProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol GeneralSearchResultProviderProtocol {
    
}

final class GeneralSearchResultProvider: GeneralSearchResultProviderProtocol {

    // MARK: - Properties
    private let service: GeneralSearchResultServiceProtocol
    
    // MARK: - Init
    init(service: GeneralSearchResultServiceProtocol =
                    GeneralSearchResultService(provider: AKNetworkProvider<GeneralSearchResultEndpoint>())) {
        self.service = service
    }
    
    // MARK: - GeneralSearchResultProviderProtocol

}
