//
//  AuthSignIn+Button.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20.05.2022.
//

import UIKit

extension AuthSignInViewController: SignInProtocol {
    func signInTapped(email: String, password: String) {
        login(email: email, password: password)
        view.endEditing(true)
        showLoader()
    }
}
