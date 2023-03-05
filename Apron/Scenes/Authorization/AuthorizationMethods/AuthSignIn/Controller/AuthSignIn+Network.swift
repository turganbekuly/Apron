//
//  AuthSignIn+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

extension AuthSignInViewController {

    // MARK: - Network

    func login(email: String, password: String) {
        interactor.login(request: .init(email: email, password: password))
    }
}
