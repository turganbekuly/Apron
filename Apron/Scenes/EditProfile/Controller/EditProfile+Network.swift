//
//  EditProfile+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models

extension EditProfileViewController {
    
    // MARK: - Network

    func updateProfile(with user: User) {
        interactor.updateProfile(request: .init(user: user))
    }
    
    func uploadImage(with image: UIImage) {
        interactor.uploadImage(request: .init(image: image))
    }
}
