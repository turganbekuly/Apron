//
//  ProfileDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 28/06/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

enum ProfileDataFlow { }

extension ProfileDataFlow {
    struct GetProfile {
        struct Request {

        }
        struct Response {
            let result: GetProfileResult
        }
        struct ViewModel {
            var state: ProfileViewController.State
        }
    }

    enum GetProfileResult {
        case successful(User)
        case failed(AKNetworkError)
    }
}

extension ProfileDataFlow {
    struct DeleteAccount {
        struct Request {
            let id: Int
        }
        struct Response {
            let result: DeleteAccountResult
        }
        struct ViewModel {
            var state: ProfileViewController.State
        }
    }

    enum DeleteAccountResult {
    case successful
    case failed(AKNetworkError)
    }
}
