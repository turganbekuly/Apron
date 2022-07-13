//
//  ShoppingList+Delegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 01.07.2022.
//

import Foundation
import M13Checkbox
import Storages
import UIKit

extension ShoppingListViewController: ShoppingListCellProtocol {
    func onCheckboxTapped(with item: CartItem, value: M13Checkbox.CheckState) {
        guard let cartItem = cartItems.first(where: { $0.productName == item.productName }) else { return }
        var bought = cartItem.bought
        if cartItem.bought {
            bought = false
        } else {
            bought = true
        }

        CartManager.shared.update(
            productName: cartItem.productName,
            productCategoryName: cartItem.productCategoryName,
            amount: cartItem.amount,
            measurement: cartItem.measurement,
            recipeName: cartItem.recipeName?.first,
            bought: bought
        )

        fetchCartItems()
    }
}
