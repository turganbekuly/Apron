//
//  EditProfileDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 23/10/2023.
//  Copyright © 2023 Apron. All rights reserved.
//

import Models

enum EditProfileDataFlow {}

extension EditProfileDataFlow {
    enum EditProfile {
        struct Request {
            let user: User
        }
        struct Response {
            let result: EditProfileResult
        }
        struct ViewModel {
            var state: EditProfileViewController.State
        }
    }
    
    enum EditProfileResult {
        case success
        case error(AKNetworkError)
    }
}

extension EditProfileDataFlow {
    enum UploadImage {
        struct Request {
            let image: UIImage
        }
        struct Response {
            let result: UploadImageResult
        }
        struct ViewModel {
            var state: EditProfileViewController.State
        }
    }

    enum UploadImageResult {
        case successful(imagePath: String)
        case failed(error: AKNetworkError)
    }
}
