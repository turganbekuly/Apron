//
//  CaloriesPageService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol CaloriesPageServiceProtocol {
    
}

final class CaloriesPageService: CaloriesPageServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<CaloriesPageEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<CaloriesPageEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - CaloriesPageServiceProtocol
    
}
