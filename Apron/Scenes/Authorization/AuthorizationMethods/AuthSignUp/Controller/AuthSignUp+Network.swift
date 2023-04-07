//
//  AuthSignUp+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models

extension AuthSignUpViewController {

    // MARK: - Network

    func signupRequest(username: String, email: String, password: String) {
        interactor.signup(request: .init(body: .init(username: username, email: email, password: password)))
    }
}
