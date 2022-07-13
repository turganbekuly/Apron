//
//  Authorization+Buttons.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.01.2022.
//

import Foundation
import Models
import UIKit
import AuthenticationServices

extension AuthorizationViewController: IAuthorizationView {
    public func buttonPressed(type: AuthorizationType) {
        switch type {
        case .signin:
            let viewController = AuthSignInBuilder(state: .initial).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(viewController, animated: false)
            }
        case .signup:
            let viewController = AuthSignUpBuilder(state: .initial).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(viewController, animated: false)
            }
        case .apple:
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]

            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            showLoader()
            authorizationController.performRequests()
        }
    }
}

extension AuthorizationViewController: ASAuthorizationControllerDelegate {
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let code = appleIDCredential.authorizationCode else {
            return
        }

        interactor.login(request: .init(code: String(data: code, encoding: .utf8) ?? ""))
        dismiss(animated: false)
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        dismiss(animated: false) {
            self.hideLoader()
        }
    }
}

extension AuthorizationViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
