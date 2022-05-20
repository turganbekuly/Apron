//
//  AuthSignIn+Button.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 20.05.2022.
//

import UIKit

extension AuthSignInViewController: SignInProtocol {
    func signInTapped() {
        let viewController = TabBarBuilder(state: .initial(.normal)).build()
        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.rootViewController = viewController
        }
    }
}
