//
//  AuthorizationDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25.05.2022.
//

import Models

enum AuthorizationDataFlow { }

extension AuthorizationDataFlow {
    // MARK: - Login

    enum Login {
        struct Request {
            let email: String
            let password: String
        }
        struct Response {
            let result: LoginResult
        }
        struct ViewModel {
            var state: AuthorizationViewController.State
        }
    }

    enum LoginResult {
        case successful(model: Auth)
        case failed(error: AKNetworkError)
    }
}
