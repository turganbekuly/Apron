//
//  EditProfileProvider.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models

protocol EditProfileProviderProtocol {
    func updateProfile(
        request: EditProfileDataFlow.EditProfile.Request,
        completion: @escaping ((EditProfileDataFlow.EditProfileResult) -> Void)
    )
    
    func uploadImage(
        request: EditProfileDataFlow.UploadImage.Request,
        completion: @escaping ((EditProfileDataFlow.UploadImageResult) -> Void)
    )
}

final class EditProfileProvider: EditProfileProviderProtocol {

    // MARK: - Properties
    private let service: EditProfileServiceProtocol
    
    // MARK: - Init
    init(service: EditProfileServiceProtocol =
                    EditProfileService(provider: AKNetworkProvider<EditProfileEndpoint>())) {
        self.service = service
    }
    
    // MARK: - EditProfileProviderProtocol

    func updateProfile(
        request: EditProfileDataFlow.EditProfile.Request,
        completion: @escaping ((EditProfileDataFlow.EditProfileResult) -> Void)
    ) {
        service.updateProfile(request: request) {
            switch $0 {
            case .success:
                completion(.success)
            case let .failure(error):
                completion(.error(error))
            }
        }
    }
    
    func uploadImage(
        request: EditProfileDataFlow.UploadImage.Request,
        completion: @escaping ((EditProfileDataFlow.UploadImageResult) -> Void)
    ) {
        service.uploadImage(request: request) {
            switch $0 {
            case let .success(json):
                if let json = json["path"] as? String {
                    completion(.successful(imagePath: json))
                } else {
                    completion(.failed(error: .invalidData))
                }
            case let .failure(error):
                completion(.failed(error: error))
            }
        }
    }
}
