//
//  EditProfileInteractor.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

protocol EditProfileBusinessLogic {
    func updateProfile(request: EditProfileDataFlow.EditProfile.Request)
    func uploadImage(request: EditProfileDataFlow.UploadImage.Request)
}

final class EditProfileInteractor: EditProfileBusinessLogic {
    
    // MARK: - Properties
    private let presenter: EditProfilePresentationLogic
    private let provider: EditProfileProviderProtocol
    
    // MARK: - Initialization
    init(presenter: EditProfilePresentationLogic,
         provider: EditProfileProviderProtocol = EditProfileProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - EditProfileBusinessLogic

    func updateProfile(request: EditProfileDataFlow.EditProfile.Request) {
        provider.updateProfile(request: request) { [weak self] in
            switch $0 {
            case .success:
                self?.presenter.updateProfile(response: .init(result: .success))
            case let .error(error):
                self?.presenter.updateProfile(response: .init(result: .error(error)))
            }
        }
    }
    
    func uploadImage(request: EditProfileDataFlow.UploadImage.Request) {
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
