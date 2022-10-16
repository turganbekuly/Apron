//
//  ShoppingList+State.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Models
import UIKit
import Storages

enum ShoppingListEntryPoint {
    case tab
    case regular
}

extension ShoppingListViewController {
    
    // MARK: - State
    public enum State {
        case initial(ShoppingListEntryPoint)
        case cartItemsDidFetch([CartItem])
        case cartItemsDidFail
        case cartItemsDidClear([CartItem])
        case cartItemsDidClearWithError
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case let .initial(initialState):
            self.initialState = initialState
            self.fetchCartItems()
        case let .cartItemsDidFetch(items):
            self.cartItems = items
        case .cartItemsDidFail:
            show(type: .error("Не удалось загрузить корзину"))
        case let .cartItemsDidClear(items):
            self.cartItems = items
        case .cartItemsDidClearWithError:
            show(type: .error("Не удалось очистить корзину"))
        }
    }
}
