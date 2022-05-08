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

extension ShoppingListViewController {
    
    // MARK: - State
    public enum State {
        case initial
        case cartItemsDidFetch([CartItem])
        case cartItemsDidFail(AKNetworkError)
    }
    
    // MARK: - Methods
    public func updateState() {
        switch state {
        case .initial:
            showLoader()
            self.fetchCartItems()
        case let .cartItemsDidFetch(items):
            hideLoader()
            self.cartItems = items
        case let .cartItemsDidFail(error):
            print(error)
        }
    }
    
}
