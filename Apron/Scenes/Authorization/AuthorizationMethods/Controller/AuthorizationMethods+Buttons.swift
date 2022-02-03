//
//  AuthorizationMethods+Buttons.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05.01.2022.
//

import Foundation

extension AuthorizationMethodsViewController: IAuthorizationMethods {
    public func methodSelected(in view: AuthorizationMethodsView, method type: AuthorizationMethodTypes) {
        switch type {
        case .apple:
            break
        case .google:
            break
        case .facebook:
            break
        case .email:
            let viewController = TabBarBuilder(state: .initial(.normal)).build()
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
}
