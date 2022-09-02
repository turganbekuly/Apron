//
//  StepByStepModeProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24/08/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import AKNetwork

protocol StepByStepModeProviderProtocol {
    
}

final class StepByStepModeProvider: StepByStepModeProviderProtocol {

    // MARK: - Properties
    private let service: StepByStepModeServiceProtocol
    
    // MARK: - Init
    init(service: StepByStepModeServiceProtocol =
                    StepByStepModeService(provider: AKNetworkProvider<StepByStepModeEndpoint>())) {
        self.service = service
    }
    
    // MARK: - StepByStepModeProviderProtocol

}
