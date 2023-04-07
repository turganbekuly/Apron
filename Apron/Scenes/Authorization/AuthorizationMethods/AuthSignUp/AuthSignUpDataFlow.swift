//
//  AuthSignUpDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

enum AuthSignUpDataFlow {

}

extension AuthSignUpDataFlow {
    enum SignUp {
        struct Request {
            let body: SignUpRequest
        }
        struct Response {
            let result: SignUpResult
        }
        struct ViewModel {
            var state: AuthSignUpViewController.State
        }
    }

    enum SignUpResult {
        case successful(model: Auth)
        case failed(error: AKNetworkError)
    }
}
