//
//  Authorization+Buttons.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.01.2022.
//

import Foundation
import Models
import UIKit

extension AuthorizationViewController: IAuthorizationView {
    public func buttonPressed(type: AuthorizationType) {
        let viewController = TabBarBuilder(state: .initial(.normal)).build()
        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.rootViewController = viewController
        }
//        var viewController: UIViewController?
//
//        switch type {
//        default:
//            interactor.login(request: .init(email: "akarysid@gmail.com", password: "12345678"))
//        }
//        switch type {
//        case .signin:
//            viewController = AuthSignInBuilder(state: .initial).build()
//        case .signup:
//            viewController = AuthSignUpBuilder(state: .initial).build()
//        }
//        guard let viewController = viewController else {
//            return
//        }

//        self.navigationController?.pushViewController(viewController, animated: false)
    }
}
