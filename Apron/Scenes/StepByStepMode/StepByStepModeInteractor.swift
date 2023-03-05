//
//  StepByStepModeInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 24/08/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol StepByStepModeBusinessLogic {

}

final class StepByStepModeInteractor: StepByStepModeBusinessLogic {

    // MARK: - Properties
    private let presenter: StepByStepModePresentationLogic
    private let provider: StepByStepModeProviderProtocol

    // MARK: - Initialization
    init(presenter: StepByStepModePresentationLogic,
         provider: StepByStepModeProviderProtocol = StepByStepModeProvider()) {
        self.presenter = presenter
        self.provider = provider
    }

    // MARK: - StepByStepModeBusinessLogic

}
