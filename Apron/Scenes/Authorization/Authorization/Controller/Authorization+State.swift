//
//  Authorization+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 04/01/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import UIKit

extension AuthorizationViewController {
    
    // MARK: - State
    public enum State {
        case initial
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            break
        }
    }
    
}
