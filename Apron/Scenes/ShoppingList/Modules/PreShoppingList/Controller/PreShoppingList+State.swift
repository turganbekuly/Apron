//
//  PreShoppingList+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 25/07/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import Storages

protocol PreShoppingListDismissedDelegate: AnyObject {
    func dismissedWithIngredients()
    func dismissed()
}

extension PreShoppingListViewController {

    // MARK: - State
    public enum State {
        case initial([CartItem], PreShoppingListDismissedDelegate)
    }

    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(items, delegate):
            self.delegate = delegate
            self.cartItems = items
        }
    }

}
