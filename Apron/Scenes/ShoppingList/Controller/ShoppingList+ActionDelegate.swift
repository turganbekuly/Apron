//
//  ShoppingList+ActionDelegate.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 01.07.2022.
//

import Foundation

extension ShoppingListViewController: CreateActionFlowProtocol {
    func handleChosenAction(type: CreateActionType) {
        switch type {
        case .clearIngredients:
            resetCartItems()
        case .shareIngredients:
            shareIngredients(cartItems: cartItems)
        default:
            break
        }
    }
}
