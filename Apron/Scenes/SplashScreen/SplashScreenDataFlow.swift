//
//  SplashScreenDataFlow.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.06.2022.
//

import Models

enum SplashScreenDataFlow { }

extension SplashScreenDataFlow {
    enum UpdateToken {
        struct Request {
            let token: String
        }
        struct Response {
            let result: UpdateTokenResult
        }
        struct ViewModel {
            var state: SplashScreenViewController.State
        }
    }

    enum UpdateTokenResult {
        case successful(accessToken: String)
        case failed(error: AKNetworkError)
    }
}
