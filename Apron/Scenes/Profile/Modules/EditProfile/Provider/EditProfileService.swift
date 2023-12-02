//
//  EditProfileService.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Extensions

protocol EditProfileServiceProtocol {
    func updateProfile(
        request: EditProfileDataFlow.EditProfile.Request,
        completion: @escaping ((AKResult) -> Void)
    )
    
    func uploadImage(
        request: EditProfileDataFlow.UploadImage.Request,
        completion: @escaping ((AKResult) -> Void)
    )
}

final class EditProfileService: EditProfileServiceProtocol {
    
    // MARK: - Properties
    private let provider: AKNetworkProvider<EditProfileEndpoint>

    // MARK: - Init
    init(provider: AKNetworkProvider<EditProfileEndpoint>) {
        self.provider = provider
    }
    
    // MARK: - EditProfileServiceProtocol
    
    func updateProfile(
        request: EditProfileDataFlow.EditProfile.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        provider.send(target: .updateProfile(user: request.user)) { result in
            completion(result)
        }
    }
    
    func uploadImage(
        request: EditProfileDataFlow.UploadImage.Request,
        completion: @escaping ((AKResult) -> Void)
    ) {
        guard let data = request.image.jpeg(.medium) else {
            completion(.failure(.invalidData))
            return
        }

        provider.send(target: .uploadImage(image: data)) { result in
            completion(result)
        }
    }
}
