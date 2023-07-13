//
//  GeneralSearchProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//



protocol GeneralSearchProviderProtocol {

}

final class GeneralSearchProvider: GeneralSearchProviderProtocol {

    // MARK: - Properties
    private let service: GeneralSearchServiceProtocol

    // MARK: - Init
    init(service: GeneralSearchServiceProtocol =
                    GeneralSearchService(provider: AKNetworkProvider<GeneralSearchEndpoint>())) {
        self.service = service
    }

    // MARK: - GeneralSearchProviderProtocol

}
