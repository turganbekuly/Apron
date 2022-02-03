//
//  InstructionsPageInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 29/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol InstructionsPageBusinessLogic {
    
}

final class InstructionsPageInteractor: InstructionsPageBusinessLogic {
    
    // MARK: - Properties
    private let presenter: InstructionsPagePresentationLogic
    private let provider: InstructionsPageProviderProtocol
    
    // MARK: - Initialization
    init(presenter: InstructionsPagePresentationLogic,
         provider: InstructionsPageProviderProtocol = InstructionsPageProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - InstructionsPageBusinessLogic

}
