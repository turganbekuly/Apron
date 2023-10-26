//
//  EditProfilePresenter.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import UIKit

protocol EditProfilePresentationLogic: AnyObject {
    func updateProfile(response: EditProfileDataFlow.EditProfile.Response)
    func uploadImage(response: EditProfileDataFlow.UploadImage.Response)
}

final class EditProfilePresenter: EditProfilePresentationLogic {
    
    // MARK: - Properties
    weak var viewController: EditProfileDisplayLogic?
    
    // MARK: - EditProfilePresentationLogic
    
    func updateProfile(response: EditProfileDataFlow.EditProfile.Response) {
        DispatchQueue.main.async {
            var viewModel: EditProfileDataFlow.EditProfile.ViewModel
            
            defer { self.viewController?.displayUpdateProfile(with: viewModel) }
            
            switch response.result {
            case .success:
                viewModel = .init(state: .profileDidUpdate)
            case let .error(error):
                viewModel = .init(state: .profileFailedUpdate(error: error))
            }
        }
    }
    
    func uploadImage(response: EditProfileDataFlow.UploadImage.Response) {
        DispatchQueue.main.async {
            var viewModel: EditProfileDataFlow.UploadImage.ViewModel

            defer { self.viewController?.displayUploadImage(with: viewModel) }

            switch response.result {
            case let .successful(imagePath):
                viewModel = .init(state: .uploadImageSucceed(imagePath))
            case let .failed(error):
                viewModel = .init(state: .uploadImageFailed(error))
            }
        }
    }
}
