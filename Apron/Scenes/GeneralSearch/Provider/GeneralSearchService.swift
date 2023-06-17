//
//  GeneralSearchService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//



protocol GeneralSearchServiceProtocol {

}

final class GeneralSearchService: GeneralSearchServiceProtocol {

    // MARK: - Properties
    private let provider: AKNetworkProvider<GeneralSearchEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<GeneralSearchEndpoint>) {
        self.provider = provider
    }

    // MARK: - GeneralSearchServiceProtocol

}
