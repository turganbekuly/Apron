//
//  InstructionsPageService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol InstructionsPageServiceProtocol {
    
}

final class InstructionsPageService: InstructionsPageServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<InstructionsPageEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<InstructionsPageEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - InstructionsPageServiceProtocol
    
}
