//
//  GeneralSearchResultService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 13/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//



protocol GeneralSearchResultServiceProtocol {

}

final class GeneralSearchResultService: GeneralSearchResultServiceProtocol {

    // MARK: - Properties
    private let provider: AKNetworkProvider<GeneralSearchResultEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<GeneralSearchResultEndpoint>) {
        self.provider = provider
    }

    // MARK: - GeneralSearchResultServiceProtocol

}
