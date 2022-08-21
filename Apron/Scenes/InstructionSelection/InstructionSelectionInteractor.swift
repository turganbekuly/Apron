//
//  InstructionSelectionInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 22/04/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol InstructionSelectionBusinessLogic {
    func uploadImage(request: InstructionSelectionDataFlow.UploadImage.Request)
}

final class InstructionSelectionInteractor: InstructionSelectionBusinessLogic {
    
    // MARK: - Properties
    private let presenter: InstructionSelectionPresentationLogic
    private let provider: InstructionSelectionProviderProtocol
    
    // MARK: - Initialization
    init(
        presenter: InstructionSelectionPresentationLogic,
        provider: InstructionSelectionProviderProtocol = InstructionSelectionProvider()
    ) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - InstructionSelectionBusinessLogic

    func uploadImage(request: InstructionSelectionDataFlow.UploadImage.Request) {
        provider.uploadImage(request: request) { [weak self] in
            switch $0 {
            case let .successful(imagePath):
                self?.presenter.uploadImage(response: .init(result: .successful(imagePath: imagePath)))
            case let .failed(error):
                self?.presenter.uploadImage(response: .init(result: .failed(error: error)))
            }
        }
    }
}
