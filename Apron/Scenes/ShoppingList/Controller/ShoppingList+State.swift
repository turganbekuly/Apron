//
//  ShoppingList+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit

extension ShoppingListViewController {
    
    // MARK: - State
    public enum State {
        case initial
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            sections = [.init(section: .ingredients, rows: [.loading])]
        }
    }
    
}
