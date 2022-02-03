//
//  Authorization+Buttons.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04.01.2022.
//

import Foundation
import Models

extension AuthorizationViewController: IAuthorizationView {
    public func buttonPressed(type: AuthorizationType) {
        let viewController = AuthorizationMethodsBuilder(state: .initial(type)).build()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overCurrentContext
        present(viewController, animated: true, completion: nil)
    }
}
