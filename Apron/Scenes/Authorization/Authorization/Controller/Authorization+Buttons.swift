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
        }
    }
}
