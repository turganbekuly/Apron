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

    enum AuthorizationWithApple {
        struct Request {
            let code: String
        }
        struct Response {
            let result: AuthorizationWithAppleResult
        }
        struct ViewModel {
            var state: AuthorizationViewController.State
        }
    }

    enum AuthorizationWithAppleResult {
        case successful(model: Auth)
        case failed(error: AKNetworkError)
    }
}
