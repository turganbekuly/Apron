//
//  AuthorizationMethods+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension AuthorizationMethodsViewController {
    
    // MARK: - State
    public enum State {
        case initial(AuthorizationType)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(type):
            self.authorizaitonType = type
        }
    }
    
}
