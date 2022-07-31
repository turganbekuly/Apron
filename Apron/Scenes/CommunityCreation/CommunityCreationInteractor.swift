//
//  CommunityCreationInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 09/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

protocol CommunityCreationBusinessLogic {
    func createCommunity(request: CommunityCreationDataFlow.CreateCommunity.Request)
    func uploadImage(request: CommunityCreationDataFlow.UploadImage.Request)
}

final class CommunityCreationInteractor: CommunityCreationBusinessLogic {
    
    // MARK: - Properties
    private let presenter: CommunityCreationPresentationLogic
    private let provider: CommunityCreationProviderProtocol
    
    // MARK: - Initialization
    init(presenter: CommunityCreationPresentationLogic,
         provider: CommunityCreationProviderProtocol = CommunityCreationProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - CommunityCreationBusinessLogic

    func createCommunity(request: CommunityCreationDataFlow.CreateCommunity.Request) {
        provider.createCommunity(request: request) { [weak self] in
            switch $0 {
            case let .successful(model):
                self?.presenter.createCommunity(response: .init(result: .successful(model: model)))
            case let .failed(error):
                self?.presenter.createCommunity(response: .init(result: .failed(error: error)))
            }
        }
    }

    func uploadImage(request: CommunityCreationDataFlow.UploadImage.Request) {
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
