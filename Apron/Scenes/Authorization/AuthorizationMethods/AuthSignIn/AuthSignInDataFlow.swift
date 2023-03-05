//
//  AuthSignInDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

enum AuthSignInDataFlow {

}

extension AuthSignInDataFlow {
    enum Login {
        struct Request {
            let email: String
            let password: String
        }
        struct Response {
            let result: LoginResult
        }
        struct ViewModel {
            var state: AuthSignInViewController.State
        }
    }

    enum LoginResult {
        case successful(model: Auth)
        case failed(error: AKNetworkError)
    }
}
