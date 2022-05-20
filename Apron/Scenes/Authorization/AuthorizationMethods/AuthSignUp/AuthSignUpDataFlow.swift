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
            let email: String
            let password: String
            let firstName: String
            let lastName: String
            let middleName: String
        }
        struct Response {

        }
        struct ViewModel {
            var state: AuthSignUpViewController.State
        }
    }

    enum SignUpResult {
        case successful(model: SignUpResponse)
        case failed(error: AKNetworkError)
    }
}
