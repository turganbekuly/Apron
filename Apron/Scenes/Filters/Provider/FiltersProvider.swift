//
//  FiltersProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/10/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol FiltersProviderProtocol {

}

final class FiltersProvider: FiltersProviderProtocol {

    // MARK: - Properties
    private let service: FiltersServiceProtocol

    // MARK: - Init
    init(service: FiltersServiceProtocol =
                    FiltersService(provider: AKNetworkProvider<FiltersEndpoint>())) {
        self.service = service
    }

    // MARK: - FiltersProviderProtocol

}
