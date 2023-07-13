//
//  StepByStepModeService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24/08/2022.
//  Copyright © 2022 Apron. All rights reserved.
//



protocol StepByStepModeServiceProtocol {

}

final class StepByStepModeService: StepByStepModeServiceProtocol {

    // MARK: - Properties
    private let provider: AKNetworkProvider<StepByStepModeEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<StepByStepModeEndpoint>) {
        self.provider = provider
    }

    // MARK: - StepByStepModeServiceProtocol

}
