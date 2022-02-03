//
//  CaloriesPageProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol CaloriesPageProviderProtocol {
    
}

final class CaloriesPageProvider: CaloriesPageProviderProtocol {

    // MARK: - Properties
    private let service: CaloriesPageServiceProtocol
    
    // MARK: - Init
    init(service: CaloriesPageServiceProtocol =
                    CaloriesPageService(provider: AKNetworkProvider<CaloriesPageEndpoint>())) {
        self.service = service
    }
    
    // MARK: - CaloriesPageProviderProtocol

}
