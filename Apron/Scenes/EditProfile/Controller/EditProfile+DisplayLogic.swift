//
//  EditProfile+DisplayLogic.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import UIKit

extension EditProfileViewController: EditProfileDisplayLogic {
    
    // MARK: - EditProfileDisplayLogic
    
    func displayUpdateProfile(with viewModel: EditProfileDataFlow.EditProfile.ViewModel) {
        state = viewModel.state
    }
    
    func displayUploadImage(with viewModel: EditProfileDataFlow.UploadImage.ViewModel) {
        state = viewModel.state
    }
}
