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
        guard let cartItem = cartItems
            .first(where: { $0.productName == item.productName && $0.measurement == item.measurement })
        else { return }
        var bought = cartItem.bought
        switch value {
        case .unchecked:
            bought = false
        case .checked:
            bought = true
        default:
            break
        }
        /// amount = nil чтобы кол-во не прибавлялась внутри корзины при каждом апдэйте
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
        
        let items = cartManager.fetchItems()
        sections = [
            .init(section: .ingredients, rows: items.compactMap { .ingredient($0) })
        ]
        
        if let index = items.firstIndex(where: { $0.productName == item.productName }) {
            let indexPath = IndexPath(row: index, section: 0)
            
            mainView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
