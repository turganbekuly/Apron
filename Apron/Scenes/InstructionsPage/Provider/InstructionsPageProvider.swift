//
//  InstructionsPageProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol InstructionsPageProviderProtocol {
    
}

final class InstructionsPageProvider: InstructionsPageProviderProtocol {

    // MARK: - Properties
    private let service: InstructionsPageServiceProtocol
    
    // MARK: - Init
    init(service: InstructionsPageServiceProtocol =
                    InstructionsPageService(provider: AKNetworkProvider<InstructionsPageEndpoint>())) {
        self.service = service
    }
    
    // MARK: - InstructionsPageProviderProtocol

}
