//
//  ShoppingList+Network.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 05/05/2022.
//  Copyright © 2022 Apron. All rights reserved.
//

import Storages

extension ShoppingListViewController {

    // MARK: - Network

    func fetchCartItems() {
        interactor.fetchCartItems(request: .init())
    }

    func resetCartItems() {
        interactor.clearCartItems(request: .init())
    }

    func removeCartItem(with name: String, measurement: String?) {
        interactor.removeCartItem(with: name, measurement: measurement)
    }
    
    func updateCart(with item: CartItem) {
        guard let cartItem = cartItems
            .first(where: { $0.productName == item.productName && $0.measurement == item.measurement })
        else { return }
        var bought = cartItem.bought
        if cartItem.bought {
            bought = false
        } else {
            bought = true
        }
        
        CartManager.shared.update(
            productId: cartItem.productId,
            productName: cartItem.productName,
            productCategoryName: cartItem.productCategoryName,
            productImage: cartItem.productImage,
            amount: nil,
            measurement: cartItem.measurement,
            recipeName: cartItem.recipeName?.first,
            bought: bought
        )
    }
}
