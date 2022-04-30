//
//  InstructionSelectionInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol InstructionSelectionBusinessLogic {
    
}

final class InstructionSelectionInteractor: InstructionSelectionBusinessLogic {
    
    // MARK: - Properties
    private let presenter: InstructionSelectionPresentationLogic
    
    // MARK: - Initialization
    init(presenter: InstructionSelectionPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - InstructionSelectionBusinessLogic

}
